import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/infinity_scroll/infinity_scroll_provider.dart';
import 'package:provider/provider.dart';

class HorizontalInfinityScrollScreen extends StatelessWidget {
  const HorizontalInfinityScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfinityScrollProvider>(
      create: (context) => InfinityScrollProvider()..started(),
      child: Consumer<InfinityScrollProvider>(builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(title: 'Infinity Scroll With Horizontal'),
          body: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              height: 200,
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (ScrollUpdateNotification notification) {
                  value.listner(notification);
                  return false;
                },
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...value.items.map((e) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            child: Image.network(
                              e,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    if (value.isMore) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: 200,
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
