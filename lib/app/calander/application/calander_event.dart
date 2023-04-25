import 'package:equatable/equatable.dart';

abstract class CalanderEvent extends Equatable {}

class CalanderStartEvent extends CalanderEvent {
  final DateTime? datTime;

  CalanderStartEvent({
    this.datTime,
  });
  @override
  List<Object?> get props => [];
}
