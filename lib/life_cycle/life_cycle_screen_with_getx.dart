import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_getx.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_ui_component.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LifeCycleScreenWithGetx extends StatelessWidget {
  const LifeCycleScreenWithGetx({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LifeCycleGetx>(
        init: LifeCycleGetx()..started(),
        builder: (state) {
          return Scaffold(
              appBar: appBar(title: "Life Cycle With Get X"),
              floatingActionButton:
                  lifeCycleUIFab(() => state.resetLocalStorage()),
              body:
                  lifeCycleUIListView(data: state.lifeCycle, context: context));
        });
  }
}
