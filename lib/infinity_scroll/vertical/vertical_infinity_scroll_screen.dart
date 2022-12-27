import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/infinity_scroll/vertical/vertical_infinity_scroll_provider.dart';
import 'package:provider/provider.dart';

class VerticalInfinityScrollScreen extends StatelessWidget {
  const VerticalInfinityScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerticalInfinityScrollProvider>(
      create: (_) => VerticalInfinityScrollProvider(),
      child: Consumer<VerticalInfinityScrollProvider>(
          builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Infinity Scroll With Vertical',
            ),
          ),
          // body: ListView.builder(itemBuilder: (context, index) {

          //   return Container();
          // }),
        );
      }),
    );
  }
}
