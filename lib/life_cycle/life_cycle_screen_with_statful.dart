import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_ui_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifeCycleScreenWithStateful extends StatefulWidget {
  const LifeCycleScreenWithStateful({super.key});

  @override
  State<LifeCycleScreenWithStateful> createState() =>
      _LifeCycleScreenWithStatefulState();
}

class _LifeCycleScreenWithStatefulState
    extends State<LifeCycleScreenWithStateful> with WidgetsBindingObserver {
  final String _lifeCycleKey = "APP_LIFE_CYCLE_CHECK_WITH_STATEFUL";
  List<String> lifeCycle = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getLocalStorage();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _setLocalStorage("Detached", isDispose: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
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

  Future<void> resetLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.remove(_lifeCycleKey);
    _getLocalStorage();
  }

  Future<void> _getLocalStorage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    setState(() {
      lifeCycle = _list;
    });
  }

  Future<void> _setLocalStorage(
    String value, {
    bool isDispose = false,
  }) async {
    String _saveData = "$value/${DateTime.now().toString().substring(0, 19)}";
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List<String> _list = _pref.getStringList(_lifeCycleKey) ?? [];
    if (isDispose) {
      _list.add(_saveData);
    } else {
      setState(() {
        _list.add(_saveData);
      });
    }
    _pref.setStringList(_lifeCycleKey, _list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Life Cycle With Stateful"),
      floatingActionButton: lifeCycleUIFab(() => resetLocalStorage()),
      body: lifeCycleUIListView(data: lifeCycle, context: context),
    );
  }
}
