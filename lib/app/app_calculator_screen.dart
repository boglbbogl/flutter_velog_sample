import 'package:flutter/material.dart';

import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';

class AppCaculatorScreen extends StatelessWidget {
  const AppCaculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Caculator App"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 10,
                        children: [
                          ...List.generate(
                              4,
                              (index) => Container(
                                    width: (size.width / 4) - 10 - (30 / 4),
                                    height: (size.width / 4) - 10 - (30 / 4),
                                    color: Colors.amber,
                                  ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 15,
                        children: [
                          Container(
                            width: (size.width / 4) - 15 - (30 / 4),
                            height: (size.width / 4) - 15 - (30 / 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(41, 41, 41, 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(61, 61, 61, 1),
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(4, 4)),
                                BoxShadow(
                                    color: Color.fromRGBO(41, 41, 41, 1),
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(-4, -4)),
                              ],
                            ),
                          ),
                          Container(
                            width: (size.width / 4) - 15 - (30 / 4),
                            height: (size.width / 4) - 15 - (30 / 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromRGBO(41, 41, 41, 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(41, 41, 41, 1),
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(4, 4)),
                                BoxShadow(
                                    color: Color.fromRGBO(61, 61, 61, 1),
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(-4, -4)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
