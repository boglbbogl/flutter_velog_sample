import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/platform_channel/battery_level/platform_battery_cubit.dart';

class PlatformBatteryScreen extends StatelessWidget {
  const PlatformBatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlatformBatteryCubit>(
      create: (context) => PlatformBatteryCubit()
        ..getBatteryLevel()
        ..listener(),
      child: BlocBuilder<PlatformBatteryCubit, PlatformBatteryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Platform Battery Level"),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      state.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: state.isConnected
                            ? Colors.blue
                            : const Color.fromRGBO(155, 155, 155, 1),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
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
                          width: (MediaQuery.of(context).size.width - 40) /
                              (100 / state.level),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
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
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        state.isConnected ? "CONNECTED" : "DISCONNECTED",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: state.isConnected
                                ? Colors.blue
                                : const Color.fromRGBO(155, 155, 155, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
