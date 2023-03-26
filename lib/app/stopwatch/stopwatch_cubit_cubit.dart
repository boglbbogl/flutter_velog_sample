import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/stopwatch/app_stopwatch_model.dart';
import 'package:flutter_velog_sample/app/stopwatch/stopwatch_cubit_state.dart';

class StopwatchCubitCubit extends Cubit<StopwatchCubitState> {
  StopwatchCubitCubit()
      : super(StopwatchCubitState(
            stopwatch: AppStopwatchModel.empty(), laps: const []));

  void _listener(int count) async {
    emit(
      state.copyWith(
          stopwatch: AppStopwatchModel(
            hour: ((state.count ~/ (60000 * 6))) > 9
                ? ((state.count ~/ (60000 * 6))).toString()
                : "0${((state.count ~/ (60000 * 6)))}",
            minute: ((state.count ~/ 6000) % 60) > 9
                ? ((state.count ~/ 6000) % 60).toString()
                : "0${((state.count ~/ 6000) % 60)}",
            seconds: ((state.count ~/ 100) % 60) > 9
                ? ((state.count ~/ 100) % 60).toString()
                : "0${((state.count ~/ 100) % 60)}",
            millseconds: ((state.count % 100).toString().padLeft(2, '0')),
          ),
          count: count + 1),
    );
  }

  void addLap() {
    HapticFeedback.mediumImpact();
    List<AppStopwatchModel> _data = state.laps;
    _data = [state.stopwatch, ...state.laps];
    emit(state.copyWith(laps: _data));
  }

  Future<void> started() async {
    HapticFeedback.mediumImpact();
    Timer? _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _listener(state.count);
    });
    emit(state.copyWith(timer: _timer, stopwatchState: StopwatchState.run));
  }

  void reset() {
    HapticFeedback.mediumImpact();
    state.timer?.cancel();
    emit(state.copyWith(
        timer: null,
        count: 0,
        stopwatchState: StopwatchState.reset,
        stopwatch: AppStopwatchModel.empty(),
        laps: []));
  }

  Future<void> stoped() async {
    if (state.stopwatchState == StopwatchState.run) {
      HapticFeedback.mediumImpact();
      state.timer?.cancel();
      emit(state.copyWith(timer: null, stopwatchState: StopwatchState.stop));
    }
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    return super.close();
  }
}
