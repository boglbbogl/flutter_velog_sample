import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_bloc.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_event.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_state.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';
import 'package:get/get.dart';

class AppCalanderScreen extends StatelessWidget {
  const AppCalanderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalanderBloc>(
      create: (_) => CalanderBloc(),
      child: BlocBuilder<CalanderBloc, CalanderState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Calander"),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context
                      .read<CalanderBloc>()
                      .add(TestEvent(test: TestModel(number: 1, name: "name"))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: MediaQueryData.fromWindow(window).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text(
                          "Open Calander",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
