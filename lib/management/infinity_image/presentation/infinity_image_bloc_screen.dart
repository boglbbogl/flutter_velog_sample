import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_bloc.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_event.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_state.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/vertical/vertical_infinity_bloc.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/vertical/vertical_infinity_event.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/vertical/vertical_infinity_state.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/vertical_image_type.dart';
import 'package:flutter_velog_sample/management/infinity_image/presentation/infinity_image_error_screen.dart';

class InfinityImageBlocScreen extends StatelessWidget {
  const InfinityImageBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                VerticalInfinityBloc()..add(VerticalInitImagesEvent())),
        BlocProvider(create: (_) => HorizontalInfinityBloc()),
      ],
      child: BlocListener<HorizontalInfinityBloc, HorizontalInfinityState>(
        listener: (context, state) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                  value: context.read<HorizontalInfinityBloc>(),
                  child: const InfinityImageErrorScreen())));
        },
        listenWhen: (previous, current) {
          if (!previous.isError) {
            return current.isError;
          } else {
            return false;
          }
        },
        child: Scaffold(
          appBar: appBar(title: "BLoC Infinity Image"),
          body: Column(
            children: [
              const SizedBox(height: 20),
              _InfinityHorizontalImageWidget(),
              const SizedBox(height: 20),
              _InfinityVerticalImageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfinityHorizontalImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HorizontalInfinityBloc, HorizontalInfinityState>(
      builder: (context, state) {
        if (state is HorizontalInitState ||
            state is HorizontalDownLoadedState) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                context
                    .read<HorizontalInfinityBloc>()
                    .add(HorizontalInitImagesEvent());
              },
              child: Icon(
                state is HorizontalDownLoadedState
                    ? Icons.download_done_rounded
                    : Icons.download_rounded,
                size: 50,
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: state.images!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: const Color.fromRGBO(71, 71, 71, 1),
                          child: Image.network(
                            state.images![index].downloadUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (index + 1 == state.images!.length) ...[
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              context
                                  .read<HorizontalInfinityBloc>()
                                  .add(HorizontalMoreImageEvent());
                            },
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              // color: Colors.amber,
                              child: state is HorizontalMoreState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.amber))
                                  : const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 30,
                                    ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}

class _InfinityVerticalImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerticalInfinityBloc, VerticalInfinityState>(
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              state.message!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ));
        }
      },
      builder: (context, state) {
        if (state.type == VerticalImageType.loading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          );
        } else {
          return Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              context
                  .read<VerticalInfinityBloc>()
                  .add(VerticalMoreImageEvent(notification));
              return false;
            },
            child: ListView.builder(
                itemCount: state.images!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: const Color.fromRGBO(91, 91, 91, 1),
                              child: Image.network(
                                state.images![index].downloadUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: 100,
                                color: const Color.fromRGBO(91, 91, 91, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _textForm(state.images![index].id),
                                    _textForm(state.images![index].author),
                                    _textForm(
                                        state.images![index].width.toString()),
                                    _textForm(
                                        state.images![index].height.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (index + 1 == state.images!.length)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: state.type == VerticalImageType.more
                                ? const CircularProgressIndicator(
                                    color: Colors.cyan,
                                  )
                                : const SizedBox(),
                          ),
                      ],
                    ),
                  );
                }),
          ));
        }
      },
    );
  }

  Padding _textForm(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 12),
      child: Text(
        content,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
