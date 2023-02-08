import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/library/equatable/bloc/library_equatable_bloc.dart';
import 'package:flutter_velog_sample/library/equatable/bloc/library_equatable_event.dart';
import 'package:flutter_velog_sample/library/equatable/bloc/library_equatable_state.dart';
import 'package:flutter_velog_sample/library/equatable/get/library_equatable_getx.dart';
import 'package:flutter_velog_sample/library/equatable/provider/library_equatable_provider.dart';
import 'package:flutter_velog_sample/library/equatable/provider/library_equatable_state_provider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

class LibraryEquatableScreen extends StatelessWidget {
  const LibraryEquatableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryEquatableStateProvider(),
      child: Consumer<LibraryEquatableStateProvider>(
          builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(title: "Equatable Library"),
          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    Text('State Change Count'),
                    Column(
                      children: [],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<LibraryEquatableGetx>(
                      init: LibraryEquatableGetx(),
                      builder: (state) {
                        print("get ${state}");
                        return _stateUI(
                            context: context,
                            title: "Get X",
                            count: state.count,
                            onIncrement: () => state.increment(),
                            onReturn: () => state.stateReturn());
                      }),
                  ChangeNotifierProvider(
                    create: (_) => LibraryEquatableProvider(),
                    child: Consumer<LibraryEquatableProvider>(
                        builder: (context, state, child) {
                      print("provider ${state}");
                      return _stateUI(
                          context: context,
                          title: "Provider",
                          count: state.count,
                          onIncrement: () => state.increment(),
                          onReturn: () => state.stateReturn());
                    }),
                  ),
                  BlocProvider(
                    create: (_) => LibraryEquatableBloc(),
                    child: BlocBuilder<LibraryEquatableBloc,
                        LibraryEquatableState>(builder: (context, state) {
                      return _stateUI(
                          context: context,
                          title: "Bloc",
                          count: state.count,
                          onIncrement: () => context
                              .read<LibraryEquatableBloc>()
                              .add(IncrementEquatableEvent()),
                          onReturn: () => context
                              .read<LibraryEquatableBloc>()
                              .add(ReturnEquatableEvent()));
                    }),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Padding _stateUI({
    required BuildContext context,
    required String title,
    required int count,
    required Function() onIncrement,
    required Function() onReturn,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48, left: 20, right: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Row(
              children: [
                _button(title: "$count", onTap: onIncrement),
                const SizedBox(width: 12),
                _button(title: "Return", onTap: onReturn),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _button({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(115, 115, 115, 1),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
