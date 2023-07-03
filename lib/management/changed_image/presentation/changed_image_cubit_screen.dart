import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/changed_image/application/changed_image_cubit.dart';
import 'package:flutter_velog_sample/management/changed_image/application/changed_image_state.dart';

class ChangedImageCubitScreen extends StatelessWidget {
  const ChangedImageCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangedImageCubit>(
        create: (context) => ChangedImageCubit()..getImage(),
        child: Scaffold(
            appBar: appBar(title: "Cubit Changed Image"),
            body: BlocBuilder<ChangedImageCubit, ChangedImageState>(
              builder: (context, state) {
                if (state is ImageLoadedState) {
                  return Column(
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              context.read<ChangedImageCubit>().getImage();
                            },
                            child: const Icon(Icons.refresh_rounded)),
                      ),
                      Image.network(
                        state.imageUrl!,
                      )
                    ],
                  );
                } else if (state is ImageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                } else if (state is ImageErrorState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )));
  }
}
