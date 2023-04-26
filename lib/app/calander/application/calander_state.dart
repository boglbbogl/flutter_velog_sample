import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';

class CalanderState extends Equatable {
  final CalanderModel calander;
  final DateTime currentDate;

  const CalanderState({
    required this.calander,
    required this.currentDate,
  });

  CalanderState copyWith({
    final CalanderModel? calander,
    final DateTime? currentDate,
  }) {
    return CalanderState(
      calander: calander ?? this.calander,
      currentDate: currentDate ?? this.currentDate,
    );
  }

  @override
  List<Object?> get props => [calander, currentDate];
}
