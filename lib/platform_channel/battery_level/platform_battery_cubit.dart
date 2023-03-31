import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformBatteryCubit extends Cubit<PlatformBatteryState> {
  PlatformBatteryCubit() : super(const NativeBatteryCheckingState());
  final MethodChannel _levelChannel =
      const MethodChannel("tyger/battery/level");
  final EventChannel _stateChannel = const EventChannel("tyger/battery/state");
  final BasicMessageChannel<String> _deviceNameChannel =
      const BasicMessageChannel<String>("tyger/device/name", StringCodec());

  Timer? _timer;

  Future<void> _tick(Timer timer, int level, String name) async {
    if (level >= timer.tick) {
      emit(NativeBatteryCheckedState(
          level: timer.tick, isConnected: state.isConnected, name: name));
    } else {
      _timer?.cancel();
    }
  }

  Future<void> listener() async {
    _stateChannel.receiveBroadcastStream().listen((event) {
      emit(NativeBatteryStatusState(
          level: state.level, isConnected: event, name: state.name));
    });
  }

  Future<void> getBatteryLevel() async {
    int? _level = await _levelChannel.invokeMethod("level");
    String _name = "";
    _deviceNameChannel.setMessageHandler((String? message) async {
      if (message != null) {
        _name = message;
      }
      return message!;
    });
    if (_level != null) {
      _timer = Timer.periodic(const Duration(milliseconds: 10),
          (Timer timer) => _tick(timer, _level, _name));
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
  final String name;
  const PlatformBatteryState({
    this.level = 0,
    this.isConnected = false,
    this.name = "",
  });
}

class NativeBatteryStatusState extends PlatformBatteryState {
  const NativeBatteryStatusState({super.level, super.isConnected, super.name});
  @override
  List<Object?> get props => [level, isConnected, name];
}

class NativeBatteryCheckingState extends PlatformBatteryState {
  const NativeBatteryCheckingState();

  @override
  List<Object?> get props => [];
}

class NativeBatteryCheckedState extends PlatformBatteryState {
  const NativeBatteryCheckedState({super.level, super.isConnected, super.name});

  @override
  List<Object?> get props => [level, isConnected, name];
}

class NativeBatteryErrorState extends PlatformBatteryState {
  final String message;
  const NativeBatteryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
