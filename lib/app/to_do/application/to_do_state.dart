import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';

abstract class TodoState extends Equatable {
  final User? user;
  final List<TodoModel>? todos;
  const TodoState({this.user, this.todos});
}

class TodoInitState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoUnUserState extends TodoState {
  const TodoUnUserState({super.user});
  @override
  List<Object?> get props => [];
}

class TodoListState extends TodoState {
  const TodoListState({super.user, super.todos});
  @override
  List<Object?> get props => [user];
}
