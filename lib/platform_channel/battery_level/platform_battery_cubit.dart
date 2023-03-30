import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/main.dart';

class PlatformBatteryCubit extends Cubit<PlatformBatteryState> {
  PlatformBatteryCubit() : super(const NativeBatteryCheckingState());
  final MethodChannel _channel = const MethodChannel("tyger/battery/level");

  Future<void> getBatteryLevel() async {
    emit(const NativeBatteryCheckingState(level: null));
    int? _level = await _channel.invokeMethod("level");
    if (_level != null) {
      emit(NativeBatteryCheckingState(level: _level));
    } else {
      emit(const NativeBatteryErrorState("Null"));
    }
    logger.e(state.level);
  }
}

abstract class PlatformBatteryState extends Equatable {
  final int? level;
  const PlatformBatteryState({
    this.level,
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
  const NativeBatteryErrorState(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
