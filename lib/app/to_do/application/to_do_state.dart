import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TodoState extends Equatable {
  final User? user;
  const TodoState({this.user});
}

class TodoInitState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoUnUserState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoListState extends TodoState {
  const TodoListState({super.user});
  @override
  List<Object?> get props => [user];
}
