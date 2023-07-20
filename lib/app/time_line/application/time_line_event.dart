import 'package:equatable/equatable.dart';

abstract class TimeLineEvent extends Equatable {}

class TimeLineLoadEvent extends TimeLineEvent {
  @override
  List<Object?> get props => [];
}
