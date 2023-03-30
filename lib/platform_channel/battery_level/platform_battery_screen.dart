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
            body: Column(
              children: [
                if (state is NativeBatteryErrorState) Text(state.message),
              ],
            ),
          );
        },
      ),
    );
  }
}
