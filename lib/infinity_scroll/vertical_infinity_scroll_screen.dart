import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/infinity_scroll/infinity_scroll_provider.dart';
import 'package:provider/provider.dart';

class VerticalInfinityScrollScreen extends StatelessWidget {
  const VerticalInfinityScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfinityScrollProvider>(
      create: (_) => InfinityScrollProvider()..started(),
      child: Consumer<InfinityScrollProvider>(builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(title: 'Infinity Scroll With Vertical'),
          body: NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              value.listner(notification);
              return false;
            },
            child: ListView.builder(
                itemCount: value.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            value.items[index],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.width - 40,
                          ),
                        ),
                      ),
                      if (value.isMore && value.currentIndex == index + 1) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ],
                  );
                }),
          ),
        );
      }),
    );
  }
}
