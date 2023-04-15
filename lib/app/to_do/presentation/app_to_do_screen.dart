import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/to_do/application/to_do_bloc.dart';
import 'package:flutter_velog_sample/app/to_do/application/to_do_event.dart';
import 'package:flutter_velog_sample/app/to_do/application/to_do_state.dart';

class AppToDoScreen extends StatelessWidget {
  const AppToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoListState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.deepOrange,
                content: Text(
                  "Not Found Todo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          if (state is TodoInitState) {
            return Container(
              color: const Color.fromRGBO(31, 31, 31, 1),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: appBar(title: "To Do"),
              body: state is TodoUnUserState
                  ? Center(
                      child: GestureDetector(
                        onTap: () => context
                            .read<TodoBloc>()
                            .add(TodoSignInWithAnonymous()),
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: kToolbarHeight +
                                    MediaQueryData.fromWindow(window)
                                        .padding
                                        .top),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.amber),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                "Sign In With Anonymous",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 24),
                              ),
                            )),
                      ),
                    )
                  : ListView(),
            );
          }
        },
      ),
    );
  }
}
