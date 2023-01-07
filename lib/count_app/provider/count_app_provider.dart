import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountAppProvider extends ChangeNotifier {
  int count = 0;
  int selectCount = 1;

  void selected(int number) {
    HapticFeedback.mediumImpact();
    selectCount = number;
    notifyListeners();
  }

  void updated(bool? isAdd) {
    HapticFeedback.mediumImpact();
    if (isAdd != null) {
      count = isAdd ? count + selectCount : count - selectCount;
      notifyListeners();
    } else {
      count = 0;
      notifyListeners();
    }
  }
}
