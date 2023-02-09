import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _detachedStateToApi() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      logger.d(response.body);
      logger.d(response.statusCode);
    }
  }

  Future<String> appLifeCycleChecked(String? message) async {
    if (message != null) {
      switch (message) {
        case "lifeCycleStateWithDetached":
          _detachedStateToApi();
          _setLocalStorage("Detached");
          break;
        case "lifeCycleStateWithResumed":
          _setLocalStorage("Resumed");
          _getLocalStorage();
          break;
        case "lifeCycleStateWithInactive":
          _setLocalStorage("Inactive");
          break;
        case "lifeCycleStateWithStop":
          _setLocalStorage("Stop");
          break;
        case "lifeCycleStateWithRestart":
          _setLocalStorage("Restart");
          break;
        default:
      }
    }
    return message!;
  }
}
