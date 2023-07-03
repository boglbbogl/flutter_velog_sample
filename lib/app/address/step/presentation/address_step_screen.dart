import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/address/step/application/address_step_cubit.dart';
import 'package:flutter_velog_sample/app/address/step/application/address_step_state.dart';

class AddressStepScreen extends StatelessWidget {
  final ScrollController controller = ScrollController();
  AddressStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressStepCubit>(
      create: (_) => AddressStepCubit()..started(),
      child: BlocBuilder<AddressStepCubit, AddressStepState>(
        builder: (context, state) {
          if (state.address == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          } else {
            return Stack(
              children: [
                Scaffold(
                  appBar: appBar(title: "Step Address"),
                  body: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: ListView.builder(
                            itemCount: state.address!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => context
                                    .read<AddressStepCubit>()
                                    .tapToScrollAnimated(
                                        index: index, controller: controller),
                                child: Container(
                                  color: state.positionIndex == index
                                      ? const Color.fromRGBO(51, 51, 51, 1)
                                      : const Color.fromRGBO(31, 31, 31, 1),
                                  width: 110,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    state.address![index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                          child: NotificationListener<ScrollUpdateNotification>(
                        onNotification: (notification) {
                          context
                              .read<AddressStepCubit>()
                              .scrollListener(notification);
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            children: [
                              ...List.generate(
                                  state.address!.length,
                                  (index) => Container(
                                        key: state.globalKeys![index],
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      130,
                                                  height: 64,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            bottom: 8),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          state.address![index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .amber),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                ...List.generate(
                                                    state.address![index].names
                                                        .length,
                                                    (i) => SizedBox(
                                                          height: 40,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(state
                                                                    .address![
                                                                        index]
                                                                    .names[i]
                                                                    .name),
                                                              ],
                                                            ),
                                                          ),
                                                        ))
                                              ],
                                            ),
                                            if (index ==
                                                state.address!.length - 1) ...[
                                              const SizedBox(height: 100),
                                            ],
                                          ],
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.animateTo(0,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.ease),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).padding.top,
                    color: Colors.white.withOpacity(0.01),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
