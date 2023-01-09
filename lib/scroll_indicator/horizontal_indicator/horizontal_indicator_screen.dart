import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/scroll_indicator/horizontal_indicator/horizontal_indicator_provider.dart';
import 'package:provider/provider.dart';

class HorizontalIndicatorScreen extends StatelessWidget {
  const HorizontalIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HorizontalIndicatorProvider>(
      create: (_) => HorizontalIndicatorProvider(),
      child: Consumer<HorizontalIndicatorProvider>(
          builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(title: 'Horizontal Indicator'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                NotificationListener<ScrollUpdateNotification>(
                  onNotification: ((notification) {
                    value.scrollListener(
                        notification: notification,
                        widthSize: (MediaQuery.of(context).size.width / 3) -
                            (MediaQuery.of(context).size.width / 3) / 2);
                    return false;
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        ...List.generate(
                            14,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.accents[index],
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(91, 91, 91, 1),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            left: value.scrollPosition,
                            child: Container(
                              height: 5,
                              width:
                                  (MediaQuery.of(context).size.width / 3) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
