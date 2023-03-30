import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/platform_channel/battery_level/platform_battery_cubit.dart';

class PlatformBatteryScreen extends StatelessWidget {
  const PlatformBatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlatformBatteryCubit>(
      create: (context) => PlatformBatteryCubit()..getBatteryLevel(),
      child: BlocBuilder<PlatformBatteryCubit, PlatformBatteryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Platform Battery Level"),
            body: SizedBox(
              width: MediaQueryData.fromWindow(window).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQueryData.fromWindow(window).size.width - 40,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(71, 71, 71, 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: state.level <= 15
                                ? Colors.red
                                : state.level < 25
                                    ? Colors.orange
                                    : Colors.green,
                          ),
                          width: (MediaQueryData.fromWindow(window).size.width -
                                  40) /
                              (100 / state.level),
                        ),
                        SizedBox(
                          width:
                              MediaQueryData.fromWindow(window).size.width - 40,
                          height: 150,
                          child: Center(
                            child: Text(
                              state is NativeBatteryErrorState
                                  ? "NULL"
                                  : state.level.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 120,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQueryData.fromWindow(window).padding.top),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
