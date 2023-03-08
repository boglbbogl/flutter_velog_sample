import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DynamicLinksSecondScreen extends StatelessWidget {
  const DynamicLinksSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Second Dynamic Links"),
      body: Container(
        width: MediaQueryData.fromWindow(window).size.width,
        height: MediaQueryData.fromWindow(window).size.height,
        color: Colors.purple,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: kToolbarHeight +
                    MediaQueryData.fromWindow(window).padding.top),
            child: const Text(
              "Second",
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
