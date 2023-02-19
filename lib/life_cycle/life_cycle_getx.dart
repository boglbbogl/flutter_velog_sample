import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifeCycleGetx extends GetxController with WidgetsBindingObserver {
  List<String> lifeCycle = [];

  void started() {
    _getLocalStorage();
  }

  final String _lifeCycleKey = "APP_LIFE_CYCLE_CHECK_WITH_GETX";

  Future<void> resetLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.remove(_lifeCycleKey);
    _getLocalStorage();
  }

  Future<void> _getLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    lifeCycle = _list;
    update();
  }

  Future<void> _setLocalStorage(String value) async {
    String _saveData = "$value/${DateTime.now().toString().substring(0, 19)}";
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    _list.add(_saveData);
    _pref.setStringList(_lifeCycleKey, _list);
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    _setLocalStorage("Detached");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        _setLocalStorage("Detached");
        break;
      case AppLifecycleState.paused:
        _setLocalStorage("Paused");
        break;
      case AppLifecycleState.inactive:
        _setLocalStorage("Inactive");
        break;
      case AppLifecycleState.resumed:
        _setLocalStorage("Resumed");
        _getLocalStorage();
        break;
      default:
    }
  }
}
