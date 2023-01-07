import 'package:flutter/material.dart';

class HorizontalIndicatorProvider extends ChangeNotifier {
  double scrollPosition = 0.0;

  void scrollListener({
    required ScrollUpdateNotification notification,
    required double widthSize,
  }) {
    double _main = 0.0;

    _main = notification.metrics.maxScrollExtent / widthSize;
    scrollPosition = (notification.metrics.pixels / _main);
    notifyListeners();
  }
}
