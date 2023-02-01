import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_native_provider.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_ui_component.dart';
import 'package:provider/provider.dart';

class LifeCycleScreenWithNative extends StatelessWidget {
  const LifeCycleScreenWithNative({super.key});

  @override
  Widget build(BuildContext context) {
    const BasicMessageChannel<String> appLifeCycleState =
        BasicMessageChannel<String>('appLifeCycle', StringCodec());
    return ChangeNotifierProvider<LifeCycleNativeProvider>(
      create: (_) => LifeCycleNativeProvider()..started(),
      child:
          Consumer<LifeCycleNativeProvider>(builder: (context, state, child) {
        appLifeCycleState.setMessageHandler(state.appLifeCycleChecked);

        return Scaffold(
          appBar: appBar(title: "Life Cycle With Native"),
          floatingActionButton:
              lifeCycleUIFab(() async => state.resetLocalStorage()),
          body: lifeCycleUIListView(data: state.lifeCycle, context: context),
        );
      }),
    );
  }
}
