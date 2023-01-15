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
          body: NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverToBoxAdapter(
                          child: Wrap(
                        children: [
                          ...List.generate(
                              10,
                              (index) => Container(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    color: Colors.accents[index],
                                  )),
                        ],
                      ))),
                ];
              }),
              body: Column(
                children: [
                  TabBar(tabs: [
                    Tab(
                      text: '1',
                    ),
                    Tab(
                      text: '2',
                    ),
                    Tab(
                      text: '3',
                    ),
                  ]),
                  Expanded(
                      child: TabBarView(children: [
                    Container(
                      width: 10,
                      color: Colors.red,
                    ),
                    Container(
                      width: 10,
                      color: Colors.green,
                    ),
                    Container(
                      width: 10,
                      color: Colors.amber,
                    ),
                  ]))
                ],
              ))),
    );
  }
}
