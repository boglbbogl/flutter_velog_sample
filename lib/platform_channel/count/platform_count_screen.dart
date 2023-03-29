import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/platform_channel/count/platform_count_cubit.dart';

class PlatformCountScreen extends StatelessWidget {
  const PlatformCountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlatformCountCubit>(
      create: (context) => PlatformCountCubit()
        ..countReset()
        ..listener(context),
      child: BlocBuilder<PlatformCountCubit, PlatformCountState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Platform Count"),
            body: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 40,
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        ...List.generate(
                            state.selectCount.length,
                            (index) => _selectButton(
                                count: state.selectCount[index],
                                currentCount: state.currentCount,
                                onTap: () => context
                                    .read<PlatformCountCubit>()
                                    .changedSelectCount(
                                        state.selectCount[index])))
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.count.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _button(
                            onTap: () =>
                                context.read<PlatformCountCubit>().increment(),
                            icon: Icons.add),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: _button(
                              onTap: () => context
                                  .read<PlatformCountCubit>()
                                  .countReset(),
                              icon: Icons.refresh,
                              width: 80),
                        ),
                        _button(
                            onTap: () =>
                                context.read<PlatformCountCubit>().decrement(),
                            icon: Icons.remove)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding _selectButton({
    required int count,
    required int currentCount,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.amber.shade200,
                  width: currentCount != count ? 0.3 : 3)),
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: currentCount != count ? Colors.white54 : Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _button({
    required Function() onTap,
    required IconData icon,
    double width = 100,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(91, 91, 91, 1),
        ),
        child: Icon(
          icon,
          size: 30,
        ),
      ),
    );
  }
}
