import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_bar.dart';

class CountScreenWithProvider extends StatelessWidget {
  const CountScreenWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Count App With Provider'),
      // body: countScreenPublicUI(
      //   context: context,
      //   count: _count,
      //   selectCount: _selectCount,
      //   onIncrement: _increment,
      //   onDecrement: _decrement,
      //   onReset: _reset,
      //   onCount: _select,
      // ),
    );
  }
}
