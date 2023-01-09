// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_app_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CountAppMobx on _CountAppMobx, Store {
  late final _$countAtom = Atom(name: '_CountAppMobx.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$selectCountAtom =
      Atom(name: '_CountAppMobx.selectCount', context: context);

  @override
  int get selectCount {
    _$selectCountAtom.reportRead();
    return super.selectCount;
  }

  @override
  set selectCount(int value) {
    _$selectCountAtom.reportWrite(value, super.selectCount, () {
      super.selectCount = value;
    });
  }

  late final _$_CountAppMobxActionController =
      ActionController(name: '_CountAppMobx', context: context);

  @override
  void increment() {
    final _$actionInfo = _$_CountAppMobxActionController.startAction(
        name: '_CountAppMobx.increment');
    try {
      return super.increment();
    } finally {
      _$_CountAppMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_CountAppMobxActionController.startAction(
        name: '_CountAppMobx.decrement');
    try {
      return super.decrement();
    } finally {
      _$_CountAppMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CountAppMobxActionController.startAction(
        name: '_CountAppMobx.reset');
    try {
      return super.reset();
    } finally {
      _$_CountAppMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void select(int number) {
    final _$actionInfo = _$_CountAppMobxActionController.startAction(
        name: '_CountAppMobx.select');
    try {
      return super.select(number);
    } finally {
      _$_CountAppMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count},
selectCount: ${selectCount}
    ''';
  }
}
