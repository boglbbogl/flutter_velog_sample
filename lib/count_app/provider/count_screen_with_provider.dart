import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';
import 'package:flutter_velog_sample/count_app/provider/count_app_provider.dart';
import 'package:provider/provider.dart';

class CountScreenWithProvider extends StatelessWidget {
  const CountScreenWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountAppProvider>(
      create: ((context) => CountAppProvider()),
      child: Consumer<CountAppProvider>(builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(title: 'Count App With Provider'),
          body: countScreenPublicUI(
            context: context,
            count: value.count,
            selectCount: value.selectCount,
            onIncrement: () => value.updated(true),
            onDecrement: () => value.updated(false),
            onReset: () => value.updated(null),
            onCount: (int number) => value.selected(number),
          ),
        );
      }),
    );
  }
}
