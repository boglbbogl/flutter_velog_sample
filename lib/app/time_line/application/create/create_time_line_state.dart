import 'package:equatable/equatable.dart';

class CreateTimeLineState extends Equatable {
  final List<String> typeList;
  final DateTime time;
  final String? type;
  final String? content;
  final bool isSubmitted;
  final bool isSuccess;

  const CreateTimeLineState({
    required this.typeList,
    required this.time,
    this.type,
    this.content,
    this.isSubmitted = false,
    this.isSuccess = false,
  });

  CreateTimeLineState copyWith({
    final List<String>? typeList,
    final DateTime? time,
    final String? type,
    final String? content,
    final bool? isSubmitted,
    final bool? isSuccess,
  }) {
    return CreateTimeLineState(
      typeList: typeList ?? this.typeList,
      time: time ?? this.time,
      type: type ?? this.type,
      content: content ?? this.content,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [typeList, time, type, content, isSubmitted, isSuccess];
}
