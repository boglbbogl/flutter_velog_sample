import 'package:flutter/material.dart';

class CountAppProvider extends ChangeNotifier {
  int count = 0;
  int selectCount = 1;

  void selected(int number) {
    selectCount = number;
    notifyListeners();
  }

  void updated(bool? isAdd) {
    if (isAdd != null) {
      count = isAdd ? count + selectCount : count - selectCount;
      notifyListeners();
    } else {
      count = 0;
      notifyListeners();
    }
  }
}
