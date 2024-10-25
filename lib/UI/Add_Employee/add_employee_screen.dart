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
import 'custom_date_picker_dialog_to.dart';
import 'date_picker_dialog.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController employeeName = TextEditingController();
  String selectedDesignation = "";
  DateTime from = DateTime.now();
  DateTime? to;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        from = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Add Employee Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.primaryColor,
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: buildEmployeeNameField(),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () => showOptions(context, (String val) {
                setState(() {
                  selectedDesignation = val;
                });
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: buildDesignationBox(),
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: buildDatePickers(),
            ),
            const Spacer(),
            buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildEmployeeNameField() {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: TextFormField(
        controller: employeeName,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.2.h),
          alignLabelWithHint: true,
          hintText: "Employee Name",
          hintStyle: TextStyle(color: Colors.black38, fontSize: 14.sp),
          prefixIcon: Image.asset(Assets.personImage),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide(color: Constants.borderColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide(color: Constants.borderColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide(color: Constants.borderColor),
          ),
        ),
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
        validator: (value) =>
            value?.isEmpty ?? true ? 'Please, fill this field.' : null,
      ),
    );
  }

  Widget buildDesignationBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.borderColor),
      ),
      width: double.infinity,
      height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.bagImage),
          SizedBox(width: 4.w),
          buildDesignationText(),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: Constants.primaryColor,
            size: 18.sp,
          ),
        ],
      ),
    );
  }

  Widget buildDesignationText() {
    return Container(
      width: 70.w,
      height: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        selectedDesignation.isEmpty ? "Role Selected" : selectedDesignation,
        style: TextStyle(
          color: selectedDesignation.isEmpty ? Colors.black38 : Colors.black,
          fontSize: selectedDesignation.isEmpty ? 14.sp : 16.sp,
        ),
      ),
    );
  }

  Widget buildDatePickers() {
    return SizedBox(
      width: 95.w,
      height: 5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildFromDatePicker(),
          SizedBox(
            width: 9.w,
            height: 5.h,
            child: const Center(
                child:
                    Icon(Icons.arrow_forward, color: Constants.primaryColor)),
          ),
          buildToDatePicker(),
        ],
      ),
    );
  }

  Widget buildFromDatePicker() {
    return GestureDetector(
      onTap: () {
        showDateTimeDialog((val) {
          setState(() {
            from = val;
          });
        });
      },
      child: buildDateContainer((DateFormat("dd MMM yyyy").format(from) ==
              DateFormat("dd MMM yyyy").format(DateTime.now()))
          ? "Today"
          : DateFormat("dd MMM yyyy").format(from)),
    );
  }

  Widget buildToDatePicker() {
    return GestureDetector(
      onTap: () {
        showToDateTimeDialog((val) {
          if (val != null && !from.isAfter(val)) {
            setState(() {
              to = val;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar("Invalid date. It should be after the from date"),
            );
          }
        });
      },
      child: buildDateContainer(
          to == null ? "No Date" : DateFormat("dd MMM yyyy").format(to!)),
    );
  }

  Widget buildDateContainer(String dateText) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.borderColor),
      ),
      width: 40.w,
      height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
      child: Row(
        children: [
          Image.asset(Assets.dateImage),
          SizedBox(width: 4.w),
          SizedBox(
            width: 24.w,
            child: Text(
              dateText,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomButtons() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Constants.borderColor)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 7.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildCancelButton(),
          SizedBox(width: 5.w),
          buildSaveButton(),
        ],
      ),
    );
  }

  Widget buildCancelButton() {
    return buildButton("Cancel", () {
      Navigation.instance.goBack();
    }, Constants.primaryColor, Colors.white);
  }

  Widget buildSaveButton() {
    return buildButton("Save", () {
      if (employeeName.text.isNotEmpty && selectedDesignation.isNotEmpty) {
        context.read<DataCubit>().addEmployee(Employee(
              employeeName.text,
              selectedDesignation,
              DateFormat("dd MMM yyyy").format(from),
              to == null ? null : DateFormat("dd MMM yyyy").format(to!),
            ));
        debugPrint("name:${employeeName.text}   designation${selectedDesignation}   from:${DateFormat("dd MMM yyyy").format(from)}    to ${to == null ? null : DateFormat("dd MMM yyyy").format(to!)}");
        Navigation.instance.navigateAndRemoveUntil(Routes.mainScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildSnackBar("Please fill up the relevant fields"),
        );
      }
    }, Colors.white, Constants.primaryColor);
  }

  Widget buildButton(String text, VoidCallback onPressed, Color textColor,
      Color backgroundColor) {
    return SizedBox(
      width: 24.w,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: backgroundColor),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
      ),
    );
  }

  SnackBar buildSnackBar(String message) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  void showOptions(BuildContext context, Function(String val) onTap) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          height: 28.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              var item = Constants.designation[index];
              return GestureDetector(
                onTap: () {
                  onTap(item);
                  Navigation.instance.goBack();
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 5.h,
                  child: Center(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const Divider(color: Constants.borderColor),
            itemCount: Constants.designation.length,
          ),
        );
      },
    );
  }

  void showDateTimeDialog(Function(DateTime val) onTap) {
    showDialog(
      barrierDismissible: true,
      context: context,
      barrierColor: Colors.black38,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        content: CustomDatePickerDialog(onTap: (val) => onTap(val)),
      ),
    );
  }

  void showToDateTimeDialog(Function(DateTime? val) onTap) {
    showDialog(
      barrierDismissible: true,
      context: context,
      barrierColor: Colors.black38,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        content: CustomDatePickerDialogTo(onTap: (DateTime? val) => onTap(val)),
      ),
    );
  }
}
