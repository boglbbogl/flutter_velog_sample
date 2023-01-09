import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';
import 'package:flutter_velog_sample/count_app/get/count_app_get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CountScreenWithGetSimple extends StatelessWidget {
  const CountScreenWithGetSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountAppGet>(
        init: CountAppGet(),
        builder: (controller) {
          return Scaffold(
            appBar: appBar(title: 'Count App With Get X(Simple)'),
            body: countScreenPublicUI(
              context: context,
              count: controller.count,
              selectCount: controller.selectCount,
              onIncrement: () {
                HapticFeedback.mediumImpact();
                controller.updated(true);
              },
              onDecrement: () {
                HapticFeedback.mediumImpact();
                controller.updated(false);
              },
              onReset: () {
                HapticFeedback.mediumImpact();
                controller.updated(null);
              },
              onCount: (int number) {
                HapticFeedback.mediumImpact();
                controller.selected(number);
              },
            ),
          );
        });
  }
}
