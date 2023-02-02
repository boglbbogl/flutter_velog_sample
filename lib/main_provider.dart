import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main_life_cycle_check_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier with WidgetsBindingObserver {
  List<String> lifeCycle = [];
  final String _lifeCycleKey = "APP_LIFE_CYCLE_CHECK_WITH_MAIN";

  Future<void> showLifeCycleBottomSheet(BuildContext context) async {
    _getLocalStorage();
    mainLifeCycleCheckView(context: context);
  }

  MainProvider() {
    WidgetsBinding.instance.addObserver(this);
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
    String _saveData =
        "$value/prvoider : ${DateTime.now().toString().substring(0, 19)}";
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    _list.add(_saveData);
    notifyListeners();
    _pref.setStringList(_lifeCycleKey, _list);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // print("detached");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        print("detached");
        _setLocalStorage("detached");

        break;
      case AppLifecycleState.paused:
        print("paused");

        _setLocalStorage("paused");
        break;
      case AppLifecycleState.inactive:
        print("inactive");

        _setLocalStorage("inactive");
        break;
      case AppLifecycleState.resumed:
        print("resumed");

        _setLocalStorage("resumed");
        _getLocalStorage();
        break;
      default:
    }
  }
}
