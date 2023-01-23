import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class TabViewPageViewScreen extends StatelessWidget {
  const TabViewPageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: appBar(title: 'Tab View With PageView'),
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
                              15,
                              (index) => Container(
                                    height: 200,
                                    width: (MediaQuery.of(context).size.width /
                                        15.00001),
                                    color: Colors.accents[index % 15],
                                  )),
                        ],
                      ))),
                ];
              }),
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
                      child: PageView(
                    children: [
                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(),
                    ],
                  ))
                ],
              ))),
    );
  }
}
