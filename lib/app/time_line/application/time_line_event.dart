import 'package:equatable/equatable.dart';

abstract class TimeLineEvent extends Equatable {}

class TimeLineLoadEvent extends TimeLineEvent {
  final DateTime? date;

  TimeLineLoadEvent({this.date});
  @override
  List<Object?> get props => [];
}

class TimeLineDateChangeEvent extends TimeLineEvent {
  final bool isIncrement;

  TimeLineDateChangeEvent({this.isIncrement = true});
  @override
  List<Object?> get props => [];
}

class TimeLineSyncEvent extends TimeLineEvent {
  final DateTime dateTime;

  TimeLineSyncEvent(this.dateTime);
  @override
  List<Object?> get props => [];
}

class TimeLineStandardChangeEvent extends TimeLineEvent {
  final bool isIncrement;

  TimeLineStandardChangeEvent(this.isIncrement);
  @override
  List<Object?> get props => [];
}
