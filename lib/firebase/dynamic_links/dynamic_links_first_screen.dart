import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DynamicLinksFirstScreen extends StatelessWidget {
  const DynamicLinksFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "First Dynamic Links"),
      body: Container(
        width: MediaQueryData.fromWindow(window).size.width,
        height: MediaQueryData.fromWindow(window).size.height,
        color: Colors.deepOrange,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: kToolbarHeight +
                    MediaQueryData.fromWindow(window).padding.top),
            child: const Text(
              "First",
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
