import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/count_app/count_screen_public_ui.dart';

class CountScreenWithRiverpod extends ConsumerWidget {
  CountScreenWithRiverpod({super.key});

  final StateProvider<int> _count = StateProvider<int>((ref) => 0);
  final StateProvider<int> _selectCount = StateProvider((ref) => 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBar(title: 'Count App With Riverpod'),
      body: countScreenPublicUI(
        context: context,
        count: ref.watch(_count),
        selectCount: ref.watch(_selectCount),
        onIncrement: () {
          HapticFeedback.mediumImpact();
          ref
              .read(_count.notifier)
              .update((state) => state + ref.watch(_selectCount));
        },
        onDecrement: () {
          HapticFeedback.mediumImpact();
          ref
              .read(_count.notifier)
              .update((state) => state - ref.watch(_selectCount));
        },
        onReset: () {
          HapticFeedback.mediumImpact();
          ref.read(_count.notifier).update((state) => 0);
        },
        onCount: (int number) {
          HapticFeedback.mediumImpact();
          ref.read(_selectCount.notifier).update((state) => number);
        },
      ),
    );
  }
}
