import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/to_do/application/create_to_do_bloc.dart';
import 'package:flutter_velog_sample/app/to_do/application/create_to_do_event.dart';
import 'package:flutter_velog_sample/app/to_do/application/create_to_do_state.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';

class AppCreateTodoScreen extends StatelessWidget {
  final TodoModel? todo;
  final String uid;
  const AppCreateTodoScreen({
    super.key,
    required this.todo,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoBloc>(
      create: (_) => CreateTodoBloc(todo: todo, uid: uid),
      child: BlocBuilder<CreateTodoBloc, CreateTodoState>(
        builder: (context, state) {
          if (state.todo == null) {
            return Container();
          } else {
            return Scaffold(
              appBar: appBar(title: "Create"),
              body: Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        DateTime? _dateTime = await showDatePicker(
                          context: context,
                          initialDate: state.todo!.dateTime.toDate(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        context
                            .read<CreateTodoBloc>()
                            .add(ChangeTodoDateEvent(_dateTime));
                      },
                      child: Text(state.todo!.dateTime
                          .toDate()
                          .toString()
                          .substring(0, 10))),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
