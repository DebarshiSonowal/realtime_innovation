import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/assets.dart';
import '../../Constants/constants.dart';
import '../../Navigation/navigate.dart';

class CustomDatePickerDialog extends StatefulWidget {
  const CustomDatePickerDialog({super.key, required this.onTap});

  final Function(DateTime val) onTap;

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime? _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: 85.w,
      height: 60.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 36.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.5),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                    ),
                    // backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentDate = DateTime.now();
                    });
                  },
                  child: Text(
                    "Today",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      // fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 36.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Constants.primaryColor),
                    elevation: MaterialStateProperty.all(0.5),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                    ),
                    // backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentDate = findNextMonday(DateTime.now());
                    });
                  },
                  child: Text(
                    "Next Monday",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 36.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.5),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                    ),
                    // backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentDate = findNextTuesday(DateTime.now());
                    });
                  },
                  child: Text(
                    "Next Tuesday",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      // fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 36.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.5),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                    ),
                    // backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentDate = DateTime.now().add(
                        const Duration(days: 7),
                      );
                    });
                  },
                  child: Text(
                    "After 1 week",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      // fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                setState(() => _currentDate = date);
              },
              todayBorderColor: Colors.transparent,
              todayButtonColor: Colors.transparent,
              thisMonthDayBorderColor: Colors.transparent,
              selectedDayBorderColor: Colors.transparent,
              selectedDayButtonColor: Colors.transparent,
              // weekDayBackgroundColor: Constants.primaryColor,
              headerTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
              leftButtonIcon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black45,
              ),
              rightButtonIcon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black45,
              ),
              // weekendTextStyle: TextStyle(
              //   color: Colors.red,
              // ),
              customDayBuilder: (
                  /// you can provide your own build function to make custom day containers
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                  ) {
                /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                /// This way you can build custom containers for specific days only, leaving rest as default.
                ///
                // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                if (isSelectedDay) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constants.primaryColor,
                      border: Border.all(
                        color: Constants.primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${day.day}",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  );
                }
                if (isToday) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Constants.primaryColor,
                      border: Border.all(
                        color: Constants.primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${day.day}",
                        style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "${day.day}",
                    style: TextStyle(
                      color: Colors.black87,
                      // fontWeight: FontWeight.bold,
                      fontSize: 12.5.sp,
                    ),
                  ),
                );
              },
              customWeekDayBuilder: (index, val) {
                return SizedBox(
                  width: 8.w,
                  child: Center(
                    child: Text(
                      val,
                      style: TextStyle(
                        color: Colors.black87,
                        // fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                );
              },
              weekFormat: false,
              // markedDatesMap: _markedDateMap,
              height: 420.0,
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: false,
              weekDayBackgroundColor: Colors.transparent,

              /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Constants.borderColor,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 1.w,
              vertical: 0.5.h,
            ),
            height: 6.h,
            width: double.infinity,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(Assets.dateImage),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      DateFormat("dd MMM yyyy").format(_currentDate!),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 20.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 2.w,
                        ),
                      ),
                      // backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigation.instance.goBack();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                SizedBox(
                  width: 20.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Constants.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.onTap(_currentDate!);
                      Navigation.instance.goBack();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime findNextTuesday(DateTime currentDate) {
    // Find the next Tuesday
    while (currentDate.weekday != DateTime.tuesday) {
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return currentDate;
  }

  DateTime findNextMonday(DateTime currentDate) {
    // Find the next Tuesday
    while (currentDate.weekday != DateTime.monday) {
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return currentDate;
  }
}
