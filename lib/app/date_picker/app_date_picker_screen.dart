import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';

class AppDatePickerScreen extends StatelessWidget {
  const AppDatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Date Picker"),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (noti) {
          final index = (noti.metrics as FixedExtentMetrics).itemIndex;
          logger.e(index);
          return false;
        },
        child: ListWheelScrollView(
            perspective: 0.0000000001,
            physics: FixedExtentScrollPhysics(),
            itemExtent: 30,
            children: [
              ...List.generate(1000, (index) => Text(index.toString()))
            ]),
      ),
      // body: Center(
      //   child: GestureDetector(
      //       onTap: () {
      //         HapticFeedback.mediumImpact();
      //       },
      //       child: Text(DateTime.now().toString())),
      // ),
    );
  }
}
