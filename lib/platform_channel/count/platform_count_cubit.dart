import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformCountCubit extends Cubit<PlatformCountState> {
  PlatformCountCubit()
      : super(const PlatformCountState(selectCount: [1, 10, 50, 100, 500]));
  final MethodChannel _countChannel = const MethodChannel("tyger/count/app");
  final MethodChannel _toastChannel = const MethodChannel("tyger/count/toast");

  void listener(BuildContext context) {
    _toastChannel.setMethodCallHandler((call) async {
      String _content = call.method;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_content)));
    });
  }

  Future<void> changedSelectCount(int count) async {
    emit(state.copyWith(currentCount: count));
  }

  Future<void> countReset() async {
    int? _count = await _countChannel.invokeMethod("reset");
    emit(state.copyWith(count: _count));
  }

  Future<void> increment() async {
    int? _count = await _countChannel.invokeMethod("increment", {
      "count": state.currentCount,
    });
    emit(state.copyWith(count: _count));
  }

  Future<void> decrement() async {
    int? _count = await _countChannel.invokeMethod("decrement", {
      "count": state.currentCount,
    });
    emit(state.copyWith(count: _count));
  }
}

class PlatformCountState extends Equatable {
  final int count;
  final int currentCount;
  final List<int> selectCount;

  const PlatformCountState({
    this.count = 0,
    this.currentCount = 1,
    required this.selectCount,
  });

  PlatformCountState copyWith({
    final int? count,
    final int? currentCount,
    final List<int>? selectCount,
  }) {
    return PlatformCountState(
        count: count ?? this.count,
        currentCount: currentCount ?? this.currentCount,
        selectCount: selectCount ?? this.selectCount);
  }

  @override
  List<Object?> get props => [count, currentCount, selectCount];
}
