import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ScrollViewWithGestureToScrollScreen extends StatelessWidget {
  const ScrollViewWithGestureToScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Scroll View With Gesture To Scroll'),
    );
  }
}
