import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/route_names.dart';
import '../../../Model/employee.dart';
import '../../../Navigation/navigate.dart';
import '../../../bloc/cubit.dart';

class PresentEmployees extends StatelessWidget {
  const PresentEmployees({
    super.key,
    required this.item,
    required this.delete,
  });

  final Function delete;
  final Employee item;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        delete();
        return true;
      },
      background: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigation.instance.navigate(Routes.editEmployeeScreen,
              args: context
                  .read<DataCubit>()
                  .state
                  .indexWhere((element) => element == item));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 1.5.h,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 0.2.h,
              ),
              Text(
                item.jobTitle,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(
                height: 0.2.h,
              ),
              Text(
                "From ${item.from}",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}