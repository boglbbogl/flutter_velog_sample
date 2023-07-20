import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';

abstract class TimeLineState extends Equatable {
  final List<TimeLineModel> timeLines;

  const TimeLineState({required this.timeLines});
}

class TimeLineLoadingState extends TimeLineState {
  const TimeLineLoadingState({required super.timeLines});

  @override
  List<Object?> get props => [timeLines];
}

class TimeLineLoadedState extends TimeLineState {
  const TimeLineLoadedState({required super.timeLines});

  @override
  List<Object?> get props => [timeLines];
}
