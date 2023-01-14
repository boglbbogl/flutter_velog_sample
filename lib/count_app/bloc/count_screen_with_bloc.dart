import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/bloc/count_app_bloc_bloc.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';

class CountScreenWithBloc extends StatelessWidget {
  const CountScreenWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountAppBlocBloc>(
      create: (context) => CountAppBlocBloc(),
      child: BlocBuilder<CountAppBlocBloc, CountAppBlocState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: 'Count App With BLoC'),
            body: countScreenPublicUI(
              context: context,
              count: state.count,
              selectCount: state.selectCount,
              onIncrement: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppBlocBloc>().add(CountAppBlocIncrement());
              },
              onDecrement: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppBlocBloc>().add(CountAppBlocDecrement());
              },
              onReset: () {
                HapticFeedback.mediumImpact();
                context.read<CountAppBlocBloc>().add(CountAppBlocReset());
              },
              onCount: (int number) {
                HapticFeedback.mediumImpact();
                context
                    .read<CountAppBlocBloc>()
                    .add(CountAppBlocSelect(number));
              },
            ),
          );
        },
      ),
    );
  }
}
