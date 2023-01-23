import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_gesture_getx.dart';
import 'package:get/get.dart';

class ScrollViewWithGestureToScrollScreen extends StatelessWidget {
  const ScrollViewWithGestureToScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollViewGestureGetx _controller = Get.put(ScrollViewGestureGetx());
    return Scaffold(
      appBar: appBar(title: 'Scroll View With Gesture To Scroll'),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: [
                _tab(context: context, title: 'Gesture To Scroll'),
                _tab(context: context, title: 'List View'),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: 1000,
                        itemBuilder: ((context, index) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Index : $index",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.accents[index % 15]),
                              ),
                            ),
                          );
                        })),
                  ),
                ),
                Obx(() => Positioned(
                      top: -_controller.topPosition.value,
                      child: GestureDetector(
                        onVerticalDragStart: (details) =>
                            _controller.dragStarted(details),
                        onVerticalDragUpdate: (details) => _controller
                            .dragUpdated(details: details, min: 0, max: 50000),
                        onVerticalDragEnd: (details) => _controller.dragEnded(
                            details: details, min: 0, max: 50000),
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 2,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ...List.generate(
                                    1000,
                                    (index) => SizedBox(
                                          height: 50,
                                          child: Text(
                                            "Index : $index",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    Colors.accents[index % 15]),
                                          ),
                                        ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _tab({
    required BuildContext context,
    required String title,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 60,
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
    );
  }
}
