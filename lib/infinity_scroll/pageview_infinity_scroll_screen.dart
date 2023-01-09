import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/infinity_scroll/infinity_scroll_provider.dart';
import 'package:provider/provider.dart';

class PageviewInfinityScrollScreen extends StatelessWidget {
  const PageviewInfinityScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfinityScrollProvider>(
      create: (context) => InfinityScrollProvider()..pageViewItems(),
      child: Consumer<InfinityScrollProvider>(
        builder: ((context, value, child) {
          return Scaffold(
            appBar: appBar(title: 'Infinity Scroll With PageView'),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: PageView(
                onPageChanged: (int index) => value.changedPage(index),
                children: [
                  ...value.items.map((e) => SizedBox(
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    color: const Color.fromRGBO(71, 71, 71, 1),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
