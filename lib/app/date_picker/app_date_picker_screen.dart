import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/date_picker/date_picker_spinner.dart';

class AppDatePickerScreen extends StatelessWidget {
  const AppDatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> _currentDate = ValueNotifier<String>(
        DateTime.now().toString().substring(0, 10).replaceAll("-", ""));
    return Scaffold(
      appBar: appBar(title: "Date Picker"),
      body: Column(
        children: [
          ValueListenableBuilder<String>(
              valueListenable: _currentDate,
              builder: (context, value, child) {
                return Container(
                  height: 150,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(230, 34, 60, 1),
                      Color.fromRGBO(210, 34, 60, 1),
                      Color.fromRGBO(150, 0, 0, 1),
                      Color.fromRGBO(150, 0, 0, 1),
                      Color.fromRGBO(210, 34, 60, 1),
                      Color.fromRGBO(230, 34, 60, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                  child: Center(
                      child: Text(
                    "${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24),
                  )),
                );
              }),
          DatePickerSpinner(
            date: DateTime.now(),
            onChanged: (value) {
              _currentDate.value = value;
            },
          ),
        ],
      ),
    );
  }
}
