import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/tab_view/pageview/tab_view_page_view_provider.dart';
import 'package:provider/provider.dart';

class TabViewPageViewScreen extends StatelessWidget {
  const TabViewPageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabViewPageViewProvider>(
      create: (_) =>
          TabViewPageViewProvider()..started(MediaQuery.of(context).size.width),
      child:
          Consumer<TabViewPageViewProvider>(builder: (context, state, child) {
        return Scaffold(
            appBar: appBar(title: 'Tab View With PageView'),
            body: Column(
              children: [
                SizedBox(
                  height: 53,
                  child: Stack(
                    children: [
                      Wrap(
                        children: [
                          _tabBar(
                            index: 0,
                            currentIndex: state.tabIndex,
                            onTap: (i) => state.tabChanged(i),
                            context: context,
                            title: 'List',
                          ),
                          _tabBar(
                            index: 1,
                            currentIndex: state.tabIndex,
                            onTap: (i) => state.tabChanged(i),
                            context: context,
                            title: 'Grid',
                          ),
                          _tabBar(
                            index: 2,
                            currentIndex: state.tabIndex,
                            onTap: (i) => state.tabChanged(i),
                            context: context,
                            title: 'Box',
                          ),
                        ],
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        bottom: 0,
                        left: state.tabIndicatorPosition,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 3,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: PageView(
                  controller: state.pageController,
                  onPageChanged: (i) => state.tabChanged(i),
                  children: [
                    ListView.builder(
                        key: const PageStorageKey("LIST_VIEW"),
                        itemCount: 1000,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                    GridView.builder(
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
                    Container(
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
                  ],
                ))
              ],
            ));
      }),
    );
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
