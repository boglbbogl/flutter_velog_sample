import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';
import 'package:flutter_velog_sample/count_app/cubit/count_app_cubit_cubit.dart';

class CountScreenWithCubit extends StatelessWidget {
  const CountScreenWithCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountAppCubitCubit>(
      create: (context) => CountAppCubitCubit(),
      child: BlocBuilder<CountAppCubitCubit, CountAppCubitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: 'Count App With Cubit'),
            body: countScreenPublicUI(
              context: context,
              count: state.count,
              selectCount: state.selectCount,
              onIncrement: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppCubitCubit>().increment();
              },
              onDecrement: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppCubitCubit>().decrement();
              },
              onReset: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppCubitCubit>().reset();
              },
              onCount: (int number) {
                HapticFeedback.mediumImpact();
                context.read<CountAppCubitCubit>().select(number);
              },
            ),
          );
        },
      ),
    );
  }
}
