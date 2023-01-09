import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';
import 'package:flutter_velog_sample/count_app/get/count_app_get.dart';
import 'package:get/get.dart';

class CountScreenWithGetReactive extends StatelessWidget {
  const CountScreenWithGetReactive({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CountAppGet());
    CountAppGet _controller = Get.find<CountAppGet>();
    return Scaffold(
        appBar: appBar(title: 'Count App With Get X(Reactive)'),
        body: Obx(
          () => countScreenPublicUI(
            context: context,
            count: _controller.rxCount.value,
            selectCount: _controller.rxSelectCount.value,
            onIncrement: () {
              HapticFeedback.mediumImpact();
              _controller.increment();
            },
            onDecrement: () {
              HapticFeedback.mediumImpact();
              _controller.decrement();
            },
            onReset: () {
              HapticFeedback.mediumImpact();
              _controller.reset();
            },
            onCount: (int number) {
              HapticFeedback.mediumImpact();
              _controller.changedCount(number);
            },
          ),
        ));
  }
}
