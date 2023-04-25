import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';

class CalanderState extends Equatable {
  final CalanderModel calander;

  const CalanderState({
    required this.calander,
  });

  CalanderState copyWith({
    final CalanderModel? calander,
  }) {
    return CalanderState(
      calander: calander ?? this.calander,
    );
  }

  @override
  List<Object?> get props => [calander];
}
