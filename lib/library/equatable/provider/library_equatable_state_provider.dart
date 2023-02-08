import 'package:flutter/material.dart';

class LibraryEquatableStateProvider extends ChangeNotifier {
  int getState = 0;
  int providerState = 0;
  int blocState = 0;

  void changed(int index) {
    switch (index) {
      case 0:
        getState = getState + 1;
        notifyListeners();
        break;
      case 1:
        providerState = providerState + 1;
        notifyListeners();
        break;
      case 2:
        blocState = blocState + 1;
        notifyListeners();
        break;
      default:
    }
  }
}
