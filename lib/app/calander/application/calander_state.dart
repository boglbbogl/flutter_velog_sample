import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';

class CalanderState extends Equatable {
  final CalanderModel calander;
  final DateTime currentDate;
  final double blur;

  const CalanderState({
    required this.calander,
    required this.currentDate,
    this.blur = 0.0,
  });

  CalanderState copyWith({
    final CalanderModel? calander,
    final DateTime? currentDate,
    final double? blur,
  }) {
    return CalanderState(
      calander: calander ?? this.calander,
      currentDate: currentDate ?? this.currentDate,
      blur: blur ?? this.blur,
    );
  }

  @override
  List<Object?> get props => [calander, currentDate, blur];
}
