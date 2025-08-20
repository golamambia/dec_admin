import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {

  // This method takes a DateTime object and returns a formatted string
  static String formatDate(DateTime date, {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(date);
  }
  static String formatDateWithMonth(String date, {String format = 'dd MMM yyyy'}) {
    var parse = DateFormat("dd-MM-yyyy").parse(date);
    return DateFormat(format).format(parse);
  }
  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = MaterialLocalizations.of(Get.context!).formatTimeOfDay(timeOfDay);
    return format;
  }

  static Future<String> datePicker() async {
    final DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(DateTime.now().year+1),
    );

    if (date != null) {
      return formatDate(date).toString();
    } else {
      return "";
    }
  }

  static Future<String> timePicker() async {
    final TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder: (context, child) =>MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ) ,

    );

    if (time != null) {
      return formatTimeOfDay(time);
    } else {
      return "";
    }
  }
}