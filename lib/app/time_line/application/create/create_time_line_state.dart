import 'package:equatable/equatable.dart';

class CreateTimeLineState extends Equatable {
  final List<String> typeList;
  final DateTime time;
  final String? type;
  final String? content;
  final bool isSubmitted;

  const CreateTimeLineState({
    required this.typeList,
    required this.time,
    this.type,
    this.content,
    this.isSubmitted = false,
  });

  CreateTimeLineState copyWith({
    final List<String>? typeList,
    final DateTime? time,
    final String? type,
    final String? content,
    final bool? isSubmitted,
  }) {
    return CreateTimeLineState(
      typeList: typeList ?? this.typeList,
      time: time ?? this.time,
      type: type ?? this.type,
      content: content ?? this.content,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [typeList, time, type, content, isSubmitted];
}
