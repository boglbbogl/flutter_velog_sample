import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ScrollViewGestureGetx extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Animation<double> scrollAnimation;
  late AnimationController scrollController;
  RxDouble topPosition = (0.0).obs;
  Offset dragStartOffset = const Offset(0, 0);
  double dragStartValue = 0.0;

  double clamping<T extends num>(T number, T low, T high) =>
      max(low * 1.0, min(number * 1.0, high * 1.0));

  void dragStarted(DragStartDetails details) {
    dragStartOffset = details.globalPosition;
    dragStartValue = topPosition.value;
  }

  void dragUpdated({
    required DragUpdateDetails details,
    required double min,
    required double max,
  }) {
    var newValue = clamping(
        dragStartValue - (details.globalPosition - dragStartOffset).dy / 1.0,
        min,
        max);
    topPosition.value = newValue;
  }

  void dragEnded({
    required DragEndDetails details,
    required double min,
    required double max,
  }) {
    double velocity = details.primaryVelocity!;
    double originalValue = topPosition.value;
    void Function() currentFlingListener =
        _flingListener(originalValue: originalValue, min: min, max: max);
    scrollController.duration = Duration(milliseconds: velocity.abs().toInt());
    scrollAnimation =
        Tween(begin: 0.0, end: velocity / 2).animate(CurvedAnimation(
      curve: Curves.fastLinearToSlowEaseIn,
      parent: scrollController,
    ))
          ..addListener(currentFlingListener);
    scrollController
      ..reset()
      ..forward();
  }

  void Function() _flingListener({
    required double originalValue,
    required double min,
    required double max,
  }) {
    return () {
      double newValue =
          clamping(originalValue - scrollAnimation.value, min, max);
      if (newValue != topPosition.value) {
        topPosition.value = newValue;
      }
    };
  }

  @override
  void onInit() {
    scrollController = AnimationController(vsync: this);
    super.onInit();
  }
}
