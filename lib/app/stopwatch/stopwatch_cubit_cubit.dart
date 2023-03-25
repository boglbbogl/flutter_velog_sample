import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/stopwatch/stopwatch_cubit_state.dart';
import 'package:flutter_velog_sample/main.dart';

class StopwatchCubitCubit extends Cubit<StopwatchCubitState> {
  StopwatchCubitCubit() : super(const StopwatchCubitState());

  Future<Timer> _listener() async {
    return Timer.periodic(const Duration(milliseconds: 10), (timer) {
      logger.e(timer.tick);
    });
  }

  Future<void> started() async {
    emit(state.copyWith(timer: await _listener()));
  }

  Future<void> stoped() async {
    state.timer?.cancel();
    emit(state.copyWith(timer: null));
  }
}
