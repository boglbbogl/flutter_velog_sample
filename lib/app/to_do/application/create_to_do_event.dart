import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';

abstract class CreateTodoEvent extends Equatable {}

class ChangeTodoDateEvent extends CreateTodoEvent {
  final DateTime? date;

  ChangeTodoDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateCheckTodoEvent extends CreateTodoEvent {
  final TodoModel? todo;
  final String uid;
  UpdateCheckTodoEvent({this.todo, required this.uid});

  @override
  List<Object?> get props => [];
}
