import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/to_do/application/create_to_do_event.dart';
import 'package:flutter_velog_sample/app/to_do/application/create_to_do_state.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';
import 'package:flutter_velog_sample/main.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc({
    TodoModel? todo,
    required String uid,
  }) : super(const CreateTodoState()) {
    on<UpdateCheckTodoEvent>(_updateCheck);
    add(UpdateCheckTodoEvent(todo: todo, uid: uid));
    on<ChangeTodoDateEvent>(_changeDate);
  }

  Future<void> _changeDate(
      ChangeTodoDateEvent event, Emitter<CreateTodoState> emit) async {
    if (event.date != null) {
      emit(CreateTodoState(
          todo:
              state.todo!.copyWith(dateTime: Timestamp.fromDate(event.date!))));
    }
  }

  Future<void> _updateCheck(
      UpdateCheckTodoEvent event, Emitter<CreateTodoState> emit) async {
    logger.e(event.uid);
    if (event.todo != null) {
      //
    } else {
      DateTime _now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      emit(CreateTodoState(
          todo: TodoModel(
        uid: event.uid,
        title: "",
        description: "",
        tag: 0,
        dateTime: Timestamp.fromDate(_now),
        isSuccess: false,
      )));
    }
  }
}
