import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ScrollViewWithViewAndBuilderScreen extends StatelessWidget {
  const ScrollViewWithViewAndBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Scroll View With View vs Builder'),
      body: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(115, 115, 115, 1),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'View',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
                Expanded(
                  child: ListView(
                    // shrinkWrap: true,
                    children: [
                      ...List.generate(
                        10000,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "View : $index",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(135, 135, 135, 1),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Builder',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 10000,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Builder : $index",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
