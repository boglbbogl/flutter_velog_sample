import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/stopwatch/app_stopwatch_model.dart';

class StopwatchCubitState extends Equatable {
  final Timer? timer;
  final AppStopwatchModel stopwatch;
  final int count;
  final StopwatchState stopwatchState;
  final List<AppStopwatchModel> laps;
  const StopwatchCubitState({
    this.timer,
    this.count = 0,
    required this.stopwatch,
    this.stopwatchState = StopwatchState.reset,
    required this.laps,
  });

  StopwatchCubitState copyWith({
    Timer? timer,
    AppStopwatchModel? stopwatch,
    int? count,
    StopwatchState? stopwatchState,
    List<AppStopwatchModel>? laps,
  }) {
    return StopwatchCubitState(
      timer: timer ?? this.timer,
      stopwatch: stopwatch ?? this.stopwatch,
      count: count ?? this.count,
      stopwatchState: stopwatchState ?? this.stopwatchState,
      laps: laps ?? this.laps,
    );
  }

  @override
  List<Object?> get props => [timer, stopwatch, count, stopwatchState, laps];
}
