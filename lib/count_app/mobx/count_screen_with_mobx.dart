import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';
import 'package:flutter_velog_sample/count_app/mobx/count_app_mobx.dart';

class CountScreenWithMobx extends StatelessWidget {
  const CountScreenWithMobx({super.key});

  @override
  Widget build(BuildContext context) {
    final CountAppMobx _counter = CountAppMobx();

    return Scaffold(
        appBar: appBar(title: 'Count App With MobX'),
        body: Observer(
          builder: (_) => countScreenPublicUI(
            context: context,
            count: _counter.count,
            selectCount: _counter.selectCount,
            onIncrement: () {
              HapticFeedback.mediumImpact();
              _counter.increment();
            },
            onDecrement: () {
              HapticFeedback.mediumImpact();
              _counter.decrement();
            },
            onReset: () {
              HapticFeedback.mediumImpact();
              _counter.reset();
            },
            onCount: (int number) {
              HapticFeedback.mediumImpact();
              _counter.select(number);
            },
          ),
        ));
  }
}
