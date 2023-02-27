import 'package:flutter/material.dart';

class SnsUIHeartProvider extends ChangeNotifier {
  bool isHeart = false;
  bool isShowHeart = false;

  void onDoubleTap() {
    isShowHeart = true;
    isHeart = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      isShowHeart = false;
      notifyListeners();
    });
  }

  void onHeartTap() {
    isHeart = !isHeart;
    notifyListeners();
  }
}
