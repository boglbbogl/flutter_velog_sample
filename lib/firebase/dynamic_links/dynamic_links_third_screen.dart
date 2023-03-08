import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DynamicLinksThirdScreen extends StatelessWidget {
  const DynamicLinksThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Third Dynamic Links"),
      body: Container(
        width: MediaQueryData.fromWindow(window).size.width,
        height: MediaQueryData.fromWindow(window).size.height,
        color: Colors.green,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: kToolbarHeight +
                    MediaQueryData.fromWindow(window).padding.top),
            child: const Text(
              "Third",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
