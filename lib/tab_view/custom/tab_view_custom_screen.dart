import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/tab_view/custom/tab_view_custom_getx.dart';
import 'package:get/get.dart';

class TabViewCustomScreen extends StatelessWidget {
  const TabViewCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabViewCustomGetx>(
        init: TabViewCustomGetx(),
        builder: (state) {
          return Scaffold(
              appBar: appBar(title: 'Tab View With Custom'),
              body: Column(
                children: [
                  SizedBox(
                    height: 53,
                    child: Stack(
                      children: [
                        Wrap(
                          children: [
                            _tabBar(
                              context: context,
                              title: 'List',
                              index: 0,
                              currentIndex: state.tabIndex,
                              onTap: (i) => state.tabChanged(i),
                            ),
                            _tabBar(
                              context: context,
                              title: 'Grid',
                              index: 1,
                              currentIndex: state.tabIndex,
                              onTap: (i) => state.tabChanged(i),
                            ),
                            _tabBar(
                              context: context,
                              title: 'Box',
                              index: 2,
                              currentIndex: state.tabIndex,
                              onTap: (i) => state.tabChanged(i),
                            ),
                          ],
                        ),
                        Obx(() => AnimatedPositioned(
                              duration:
                                  Duration(milliseconds: state.duration.value),
                              bottom: 0,
                              left: state.indicatorPosition.value,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 3,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        _tabView(
                          context: context,
                          duration: state.duration,
                          position: state.positions[0],
                          onUpdate: (details) =>
                              state.horizontalPanUpdated(details),
                          onEnd: (details) => state.horizontalPanEnded(details),
                          body: ListView.builder(
                              key: const PageStorageKey("LIST_VIEW"),
                              itemCount: 1000,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      "List View $index",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.accents[index % 15],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        _tabView(
                          context: context,
                          duration: state.duration,
                          position: state.positions[1],
                          onUpdate: (details) =>
                              state.horizontalPanUpdated(details),
                          onEnd: (details) => state.horizontalPanEnded(details),
                          body: GridView.builder(
                              key: const PageStorageKey("GRID_VIEW"),
                              itemCount: 1000,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemBuilder: ((context, index) {
                                List<int> _number = [
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  Random().nextInt(255)
                                ];
                                return Container(
                                  color: Color.fromRGBO(
                                      _number[0], _number[1], _number[2], 1),
                                  child: Center(
                                      child: Text(
                                    "Grid View $index",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              })),
                        ),
                        _tabView(
                          context: context,
                          duration: state.duration,
                          position: state.positions[2],
                          onUpdate: (details) =>
                              state.horizontalPanUpdated(details),
                          onEnd: (details) => state.horizontalPanEnded(details),
                          body: Container(
                            width: 10,
                            color: const Color.fromRGBO(91, 91, 91, 1),
                            child: const Center(
                              child: Text(
                                'Box',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Obx _tabView({
    required BuildContext context,
    required RxInt duration,
    required RxDouble position,
    required Function(DragUpdateDetails) onUpdate,
    required Function(DragEndDetails) onEnd,
    required Widget body,
  }) {
    return Obx(() => AnimatedPositioned(
          duration: Duration(milliseconds: duration.value),
          left: position.value,
          child: GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) =>
                onUpdate(details),
            onHorizontalDragEnd: (DragEndDetails details) => onEnd(details),
            child: Container(
              color: Colors.transparent,
              height: Get.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
              width: Get.width,
              child: body,
            ),
          ),
        ));
  }

  GestureDetector _tabBar({
    required BuildContext context,
    required String title,
    required int index,
    required int currentIndex,
    required Function(int) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width / 3,
        height: 50,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            color: currentIndex == index
                ? Colors.white
                : const Color.fromRGBO(215, 215, 215, 1),
            fontWeight: FontWeight.bold,
            fontSize: currentIndex == index ? 20 : 18,
          ),
        )),
      ),
    );
  }
}
