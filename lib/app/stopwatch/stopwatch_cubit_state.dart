import 'dart:async';

import 'package:equatable/equatable.dart';

class StopwatchCubitState extends Equatable {
  final Timer? timer;
  const StopwatchCubitState({
    this.timer,
  });

  StopwatchCubitState copyWith({
    Timer? timer,
  }) {
    return StopwatchCubitState(
      timer: timer,
    );
  }

  @override
  List<Object?> get props => [];
}
