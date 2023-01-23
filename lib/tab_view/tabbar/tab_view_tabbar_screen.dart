import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class TabViewTabbarScreen extends StatelessWidget {
  const TabViewTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: appBar(title: 'Tab View With Tabbar'),
          body: Column(
            children: [
              const TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      text: 'List',
                      height: 50,
                    ),
                    Tab(
                      text: 'Grid',
                      height: 50,
                    ),
                    Tab(
                      text: 'Box',
                      height: 50,
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
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
              ]))
            ],
          )),
    );
  }
}
