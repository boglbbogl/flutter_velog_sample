import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';

class CountScreenWithStateFul extends StatefulWidget {
  const CountScreenWithStateFul({super.key});

  @override
  State<CountScreenWithStateFul> createState() =>
      _CountScreenWithStateFulState();
}

class _CountScreenWithStateFulState extends State<CountScreenWithStateFul> {
  int _count = 0;
  int _selectCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Count App With State Ful'),
        body: countScreenPublicUI(
          context: context,
          count: _count,
          selectCount: _selectCount,
          onIncrement: _increment,
          onDecrement: _decrement,
          onReset: _reset,
          onCount: _select,
        ));
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _select(int number) {
    setState(() {
      _selectCount = number;
    });
  }

  void _increment() {
    setState(() {
      _count = _count + _selectCount;
    });
  }

  void _decrement() {
    setState(() {
      _count = _count - _selectCount;
    });
  }
}
