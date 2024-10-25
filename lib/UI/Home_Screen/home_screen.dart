import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/assets.dart';
import '../../Constants/constants.dart';
import '../../Constants/route_names.dart';
import '../../Model/employee.dart';
import '../../Navigation/navigate.dart';
import '../../bloc/cubit.dart';
import 'Widgets/past_employees.dart';
import 'Widgets/present_employees.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildAppBarTitle(),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigation.instance.navigate(Routes.addEmployeeScreen),
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        color: Constants.bgColor,
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<DataCubit, List<Employee>>(
          builder: (context, data) {
            if (data.isEmpty) return _buildEmptyImage();
            final currentEmployees = filterEmployees(data, isCurrent: true);
            final pastEmployees = filterEmployees(data, isCurrent: false);

            return Column(
              children: [
                if (currentEmployees.isNotEmpty) _buildSectionTitle("Current employees"),
                _buildEmployeeList(currentEmployees, isCurrent: true),
                if (pastEmployees.isNotEmpty) _buildSectionTitle("Previous employees"),
                _buildEmployeeList(pastEmployees, isCurrent: false),
                _buildFooterText(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Employee List",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildEmptyImage() {
    return Center(child: Image.asset(Assets.noImages));
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: double.infinity,
      height: 5.h,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(List<Employee> employees, {required bool isCurrent}) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: employees.length,
      itemBuilder: (context, index) {
        var item = employees[index];
        return isCurrent
            ? PresentEmployees(
                item: item,
                delete: () => _deleteEmployee(context, item),
              )
            : PastEmployeesItem(
                item: item,
                delete: () => _deleteEmployee(context, item),
              );
      }, separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey.shade100,
          thickness: 0.1.h,
          height: 0.1.h,
        );
    },
    );
  }

  void _deleteEmployee(BuildContext context, Employee item) {
    context.read<DataCubit>().delete(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Employee data has been deleted",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                (Navigation.instance.navigatorKey.currentContext ?? context)
                    .read<DataCubit>()
                    .undo();
                ScaffoldMessenger.of(Navigation.instance.navigatorKey.currentContext ?? context).clearSnackBars();
              },
              child: Text(
                "Undo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "Swipe to delete",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> filterEmployees(List<Employee> employees, {required bool isCurrent}) {
    return employees.where((e) {
      DateTime? toDate;

      // Attempt to parse the 'to' date
      if (e.to != null) {
        toDate = DateFormat('dd MMM yyyy').parse(e.to!); // Ensure the date format is correct
      }

      // Debug output to see employee data and filtering conditions
      print("Filtering employee: ${e.toJson()}");
      print("Parsed 'to' date for ${e.name}: $toDate");

      if (isCurrent) {
        // Check if the employee is current
        bool isOngoing = toDate == null; // Ongoing if 'to' is null
        bool isFuture = toDate != null && toDate.isAfter(DateTime.now()); // Future if 'to' is after today
        bool isToday = toDate != null && toDate.isAtSameMomentAs(DateTime.now()); // Today if 'to' is today

        return isOngoing || isFuture || isToday; // Return true if any condition is met
      } else {
        // Check if the employee is past
        return toDate != null && toDate.isBefore(DateTime.now()); // Past if 'to' is before today
      }
    }).toList();
  }






}
