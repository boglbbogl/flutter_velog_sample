import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/date_picker/date_picker_spinner.dart';

class AppDatePickerScreen extends StatelessWidget {
  const AppDatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> _currentDate = ValueNotifier<String>(
        DateTime.now().toString().substring(0, 10).replaceAll("-", ""));
    ValueNotifier<String> _sheetDate = ValueNotifier<String>(
        DateTime.now().toString().substring(0, 10).replaceAll("-", ""));
    return Scaffold(
      appBar: appBar(title: "Date Picker"),
      body: Column(
        children: [
          _form(
              valueListenable: _sheetDate,
              colors: const [
                Color.fromRGBO(55, 140, 80, 1),
                Color.fromRGBO(55, 160, 80, 1),
                Color.fromRGBO(55, 198, 80, 1),
                Color.fromRGBO(55, 198, 80, 1),
                Color.fromRGBO(55, 160, 80, 1),
                Color.fromRGBO(55, 140, 80, 1),
              ],
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: const Color.fromRGBO(71, 71, 71, 1),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              DatePickerSpinner(
                                date: DateTime.now(),
                                onChanged: (value) => _sheetDate.value = value,
                              ),
                            ],
                          ),
                          Positioned(
                              right: 20,
                              top: 30,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 24,
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                  enableDrag: false,
                );
              }),
          SizedBox(
              height: MediaQuery.of(context).size.height -
                  (540 + kToolbarHeight + MediaQuery.of(context).padding.top)),
          _form(
            valueListenable: _currentDate,
            colors: const [
              Color.fromRGBO(230, 34, 60, 1),
              Color.fromRGBO(210, 34, 60, 1),
              Color.fromRGBO(150, 0, 0, 1),
              Color.fromRGBO(150, 0, 0, 1),
              Color.fromRGBO(210, 34, 60, 1),
              Color.fromRGBO(230, 34, 60, 1),
            ],
            onTap: () {},
          ),
          DatePickerSpinner(
            date: DateTime.now(),
            interval: 1200,
            onChanged: (value) => _currentDate.value = value,
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder _form({
    required ValueNotifier<String> valueListenable,
    required List<Color> colors,
    required Function() onTap,
  }) {
    return ValueListenableBuilder<String>(
        valueListenable: valueListenable,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              onTap();
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Center(
                  child: Text(
                "${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22),
              )),
            ),
          );
        });
  }
}
