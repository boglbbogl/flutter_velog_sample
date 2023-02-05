import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppCalculatorProvider extends ChangeNotifier {
  List<dynamic> currentContents = [];
  int result = 0;

  void changedButtonClicked(String? symbol, int? number) {
    HapticFeedback.mediumImpact();
    if (number != null) {
      if (currentContents.isNotEmpty) {
        bool _isNumber = currentContents.last is int;
        if (_isNumber) {
          currentContents[currentContents.length - 1] = int.parse(
              "${currentContents[currentContents.length - 1]}" "$number");
        } else {
          currentContents.add(number);
        }
      } else {
        currentContents = [number];
      }
    } else {
      if (symbol == "AC") {
        currentContents.clear();
        result = 0;
      } else {
        if (currentContents.isNotEmpty) {
          bool _isNumber = currentContents.last is int;
          if (_isNumber) {
            currentContents.add(symbol);
          } else {
            currentContents
              ..removeLast()
              ..add(symbol);
          }
        }
      }
    }
    _calcurator();
  }

  void _calcurator() {
    if (currentContents.length % 2 != 0 && currentContents.length > 2) {
      switch (currentContents[1]) {
        case "+":
          result = currentContents[0] + currentContents[2];
          break;
        case "-":
          result = currentContents[0] - currentContents[2];
          break;
        case "/":
          result = currentContents[0] / currentContents[2];
          break;
        case "*":
          result = currentContents[0] * currentContents[2];
          break;
        default:
      }
    } else {
      if (currentContents.length > 3) {
        String _symbol = currentContents.last;
        currentContents.clear();
        currentContents
          ..add(result)
          ..add(_symbol);
      }
    }
    notifyListeners();
  }
}
