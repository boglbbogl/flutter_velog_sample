import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';

class CountScreenWithListenarable extends StatelessWidget {
  const CountScreenWithListenarable({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> _count = ValueNotifier<int>(0);
    ValueNotifier<int> _selectCount = ValueNotifier<int>(1);

    return Scaffold(
      appBar: appBar(title: 'Count App With Listenerable'),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: ValueListenableBuilder<int>(
                        valueListenable: _count,
                        builder: (
                          BuildContext context,
                          int count,
                          Widget? child,
                        ) {
                          return Text(
                            "$count",
                            style: const TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          );
                        }),
                  )),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _count.value = _count.value + _selectCount.value;
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _count.value = _count.value - _selectCount.value;
                    },
                    child: const Icon(
                      Icons.remove_circle_outline,
                      size: 40,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  _count.value = 0;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 48,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(71, 71, 71, 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Reset',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
          Positioned(
            top: 20,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ValueListenableBuilder<int>(
                    valueListenable: _selectCount,
                    builder: (
                      BuildContext context,
                      int number,
                      Widget? child,
                    ) {
                      return Column(
                        children: [
                          countAppSelectedCountBox(
                              onTap: (number) {
                                HapticFeedback.mediumImpact();
                                _selectCount.value = number;
                              },
                              selectNumber: _selectCount.value,
                              number: 1),
                          countAppSelectedCountBox(
                              onTap: (number) {
                                HapticFeedback.mediumImpact();
                                _selectCount.value = number;
                              },
                              selectNumber: _selectCount.value,
                              number: 10),
                          countAppSelectedCountBox(
                              onTap: (number) {
                                HapticFeedback.mediumImpact();
                                _selectCount.value = number;
                              },
                              selectNumber: _selectCount.value,
                              number: 20),
                          countAppSelectedCountBox(
                              onTap: (number) {
                                HapticFeedback.mediumImpact();
                                _selectCount.value = number;
                              },
                              selectNumber: _selectCount.value,
                              number: 50),
                          countAppSelectedCountBox(
                              onTap: (number) {
                                HapticFeedback.mediumImpact();
                                _selectCount.value = number;
                              },
                              selectNumber: _selectCount.value,
                              number: 100),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
