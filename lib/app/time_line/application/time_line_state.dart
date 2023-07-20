import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';

abstract class TimeLineState extends Equatable {
  final List<TimeLineModel> timeLines;
  final int interval;
  final DateTime currentDate;
  final double standardIndex;

  const TimeLineState({
    required this.timeLines,
    required this.currentDate,
    this.interval = 0,
    this.standardIndex = 1,
  });
}

class TimeLineLoadingState extends TimeLineState {
  const TimeLineLoadingState({
    required super.timeLines,
    required super.currentDate,
  });

  @override
  List<Object?> get props => [timeLines];
}

class TimeLineLoadedState extends TimeLineState {
  const TimeLineLoadedState({
    required super.timeLines,
    required super.interval,
    required super.currentDate,
    required super.standardIndex,
  });

  @override
  List<Object?> get props => [timeLines, currentDate, standardIndex];
}

class TimeLineChangeLoadingState extends TimeLineState {
  const TimeLineChangeLoadingState({
    required super.timeLines,
    required super.currentDate,
    required super.interval,
    required super.standardIndex,
  });

  @override
  List<Object?> get props => [timeLines, currentDate, standardIndex];
}
