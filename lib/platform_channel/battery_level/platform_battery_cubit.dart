import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/main.dart';

class PlatformBatteryCubit extends Cubit<PlatformBatteryState> {
  PlatformBatteryCubit() : super(const NativeBatteryCheckingState());
  final MethodChannel _levelChannel =
      const MethodChannel("tyger/battery/level");
  final EventChannel _stateChannel = const EventChannel("tyger/battery/state");

  Timer? _timer;

  Future<void> _tick(Timer timer, int level) async {
    if (level >= timer.tick) {
      emit(NativeBatteryCheckedState(
          level: timer.tick, isConnected: state.isConnected));
    } else {
      _timer?.cancel();
    }
  }

  Future<void> listener() async {
    _stateChannel.receiveBroadcastStream().listen((event) {
      emit(NativeBatteryStatusState(level: state.level, isConnected: event));
      logger.e(state.isConnected);
    });
  }

  Future<void> getBatteryLevel() async {
    int? _level = await _levelChannel.invokeMethod("level");
    if (_level != null) {
      _timer = Timer.periodic(const Duration(milliseconds: 10),
          (Timer timer) => _tick(timer, _level));
    } else {
      emit(const NativeBatteryErrorState("Null"));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

abstract class PlatformBatteryState extends Equatable {
  final int level;
  final bool isConnected;
  const PlatformBatteryState({
    this.level = 0,
    this.isConnected = false,
  });
}

class NativeBatteryStatusState extends PlatformBatteryState {
  const NativeBatteryStatusState({super.level, super.isConnected});
  @override
  List<Object?> get props => [level, isConnected];
}

class NativeBatteryCheckingState extends PlatformBatteryState {
  const NativeBatteryCheckingState();

  @override
  List<Object?> get props => [];
}

class NativeBatteryCheckedState extends PlatformBatteryState {
  const NativeBatteryCheckedState({super.level, super.isConnected});

  @override
  List<Object?> get props => [level, isConnected];
}

class NativeBatteryErrorState extends PlatformBatteryState {
  final String message;
  const NativeBatteryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
