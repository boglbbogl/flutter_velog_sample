import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';

class CreateTodoState extends Equatable {
  final TodoModel? todo;

  const CreateTodoState({this.todo});

  CreateTodoState copyWith(
    final TodoModel? todo,
  ) {
    return CreateTodoState(
      todo: todo,
    );
  }

  @override
  List<Object?> get props => [todo];
}
