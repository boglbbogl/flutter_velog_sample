import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TodoEvent extends Equatable {}

class TodoUserCheckEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoSignInWithAnonymous extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoListEvent extends TodoEvent {
  final User? user;
  TodoListEvent({this.user});
  @override
  List<Object?> get props => [];
}
