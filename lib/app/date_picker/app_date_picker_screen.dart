import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/date_picker/date_picker_spinner.dart';

class AppDatePickerScreen extends StatelessWidget {
  const AppDatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Date Picker"),
      body: Column(
        children: [
          DatePickerSpinner(
            date: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
