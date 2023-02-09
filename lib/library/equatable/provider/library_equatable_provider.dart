import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LibraryEquatableProvider extends ChangeNotifier {
  int _count = 0;

  void increment() {
    _count = _count + 1;
    notifyListeners();
  }

  void stateReturn() {
    _count;
    notifyListeners();
  }

  int get count => _count;
}

class CountModel extends Equatable {
  final int count;
  const CountModel(this.count);

  @override
  List<Object?> get props => [count];
}
