import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/scroll_indicator/vertical_indicator/vertical_indicator_provider.dart';
import 'package:provider/provider.dart';

class VerticalIndicatorScreen extends StatelessWidget {
  const VerticalIndicatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerticalIndicatorProvider()..started(context: context),
      child:
          Consumer<VerticalIndicatorProvider>(builder: (context, value, child) {
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollUpdateNotification notification) {
            value.listener();
            return false;
          },
          child: Scaffold(
            appBar: appBar(title: 'Vertical Indicator'),
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: value.scrollController,
                  child: Column(
                    children: [
                      ...List.generate(
                          value.indexSample.length,
                          (index) => SizedBox(
                              width: size.width,
                              height: 60,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width / 2.5),
                                child: Text(
                                  value.indexSample[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: value.color[index],
                                  ),
                                ),
                              ))),
                      if (value.isMoreLoading) ...[
                        const SizedBox(
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Positioned(
                  right: 8,
                  top: value.verticalPosition,
                  child: Container(
                    width: 5,
                    height: value.verticalHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(175, 175, 175, 1),
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
