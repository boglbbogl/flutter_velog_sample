import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformBatteryCubit extends Cubit<PlatformBatteryState> {
  PlatformBatteryCubit() : super(const NativeBatteryCheckingState());
  final MethodChannel _levelChannel =
      const MethodChannel("tyger/battery/level");

  Timer? _timer;

  Future<void> _tick(Timer timer, int level) async {
    if (level >= timer.tick) {
      emit(NativeBatteryCheckedState(level: timer.tick));
    } else {
      _timer?.cancel();
    }
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
  const PlatformBatteryState({
    this.level = 0,
  });
}

class NativeBatteryCheckingState extends PlatformBatteryState {
  const NativeBatteryCheckingState({super.level});

  @override
  List<Object?> get props => [level];
}

class NativeBatteryCheckedState extends PlatformBatteryState {
  const NativeBatteryCheckedState({super.level});

  @override
  List<Object?> get props => [level];
}

class NativeBatteryErrorState extends PlatformBatteryState {
  final String message;
  const NativeBatteryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
