import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_ui_component.dart';

class LifeCycleScreenWithNative extends StatelessWidget {
  const LifeCycleScreenWithNative({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Life Cycle With Native"),
      floatingActionButton: lifeCycleUIFab(() async {}),
    );
  }
}
