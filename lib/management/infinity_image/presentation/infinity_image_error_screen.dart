import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_bloc.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_event.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_state.dart';

class InfinityImageErrorScreen extends StatelessWidget {
  const InfinityImageErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HorizontalInfinityBloc, HorizontalInfinityState>(
      listener: (context, state) {
        if (!state.isError) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: appBar(title: "BLoC Error"),
        body: Center(
          child: IconButton(
              iconSize: 100,
              onPressed: () {
                HapticFeedback.mediumImpact();
                context
                    .read<HorizontalInfinityBloc>()
                    .add(HorizontalInitImagesEvent());
              },
              icon: const Icon(
                Icons.refresh_rounded,
              )),
        ),
      ),
    );
  }
}
