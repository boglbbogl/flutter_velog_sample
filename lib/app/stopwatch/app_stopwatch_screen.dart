import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/stopwatch/stopwatch_cubit_cubit.dart';
import 'package:flutter_velog_sample/app/stopwatch/stopwatch_cubit_state.dart';

class AppStopWatchScreen extends StatelessWidget {
  const AppStopWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchCubitCubit>(
      create: (context) => StopwatchCubitCubit(),
      child: BlocBuilder<StopwatchCubitCubit, StopwatchCubitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Stopwatch"),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        context.read<StopwatchCubitCubit>().stoped();
                      },
                      child: Text("stop")),
                  GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        context.read<StopwatchCubitCubit>().started();
                      },
                      child: Text("start")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
