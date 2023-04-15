import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/to_do/application/to_do_event.dart';
import 'package:flutter_velog_sample/app/to_do/application/to_do_state.dart';
import 'package:flutter_velog_sample/app/to_do/repository/to_do_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository = TodoRepository.instance;
  TodoBloc() : super(TodoInitState()) {
    on<TodoUserCheckEvent>(_userCheck);
    on<TodoSignInWithAnonymous>(_signInWithAnonymous);
    on<TodoListEvent>(_list);
    add(TodoUserCheckEvent());
  }

  Future<void> _list(TodoListEvent event, Emitter<TodoState> emit) async {
    await _repository.readTodoList(uid: event.user!.uid);
    emit(TodoListState(user: event.user));
  }

  Future<void> _userCheck(
      TodoUserCheckEvent event, Emitter<TodoState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    User? _user = await _repository.currentUserCheck();
    if (_user != null) {
      add(TodoListEvent(user: _user));
    } else {
      emit(TodoUnUserState());
    }
  }

  Future<void> _signInWithAnonymous(
      TodoSignInWithAnonymous event, Emitter<TodoState> emit) async {
    if (state is TodoUnUserState) {
      HapticFeedback.mediumImpact();
      User? _user = await _repository.signInWithAnonymous();
      if (_user != null) {
        emit(TodoListState(user: _user));
      } else {
        emit(TodoUnUserState());
      }
    }
  }
}
