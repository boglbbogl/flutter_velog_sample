import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_bloc.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_event.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_state.dart';

class AppCalanderScreen extends StatelessWidget {
  const AppCalanderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalanderBloc>(
      create: (_) => CalanderBloc()..add(CalanderStartEvent()),
      child: BlocBuilder<CalanderBloc, CalanderState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Calander"),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQueryData.fromWindow(window).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(71, 71, 71, 1)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 24),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.amber),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.calander.year.toString()),
                              Text(state.calander.month.toString()),
                            ],
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          ...List.generate(
                            7,
                            (index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1))),
                              height:
                                  MediaQueryData.fromWindow(window).size.width /
                                      7,
                              width:
                                  MediaQueryData.fromWindow(window).size.width /
                                      7,
                              child: Center(
                                child: Text(
                                  ["S", "M", "T", "W", "T", "F", "S"][index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          ...List.generate(
                            state.calander.days.length,
                            (index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1))),
                              height:
                                  MediaQueryData.fromWindow(window).size.width /
                                      7,
                              width:
                                  MediaQueryData.fromWindow(window).size.width /
                                      7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4, top: 4),
                                child: Text(
                                  state.calander.days[index] == 0
                                      ? ""
                                      : state.calander.days[index].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
