import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifeCycleNativeProvider extends ChangeNotifier {
  List<String> lifeCycle = [];
  final String _lifeCycleKey = "APP_LIFE_CYCLE_CHECK_WITH_NATIVE";

  Future<void> started() async {
    _getLocalStorage();
  }

  Future<void> resetLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.remove(_lifeCycleKey);
    _getLocalStorage();
  }

  Future<void> _getLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    lifeCycle = _list;
    notifyListeners();
  }

  Future<void> _setLocalStorage(String value) async {
    String _saveData = "$value/${DateTime.now().toString().substring(0, 19)}";
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    _list.add(_saveData);
    notifyListeners();
    _pref.setStringList(_lifeCycleKey, _list);
  }

  Future<String> appLifeCycleChecked(String? message) async {
    if (message != null) {
      switch (message) {
        case "willEnterForeground":
          _setLocalStorage("resumed");
          _getLocalStorage();
          break;
        case "didEnterBackground":
          _setLocalStorage("inactive");
          break;
        case "willTerminate":
          _setLocalStorage("detached");
          break;
        default:
      }
    }
    return message!;
  }
}
