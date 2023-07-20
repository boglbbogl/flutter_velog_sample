import 'package:flutter/material.dart';

String timeLineDateToString(DateTime date) {
  String month = date.month > 9 ? "${date.month}" : "0${date.month}";
  String day = date.day > 9 ? "${date.day}" : "0${date.day}";
  return "${date.year}-$month-$day";
}

String timeLineTimeToString(TimeOfDay time) {
  String hour = time.hour > 9 ? "${time.hour}" : "0${time.hour}";
  String minute = time.minute > 9 ? "${time.minute}" : "0${time.minute}";

  return "$hour:$minute";
}
