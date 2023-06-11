import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class NetworkImageScreen extends StatelessWidget {
  const NetworkImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Network Images"),
      body: Column(
        children: [
          _button(title: "Network Images"),
          _button(title: "Performance"),
          _button(title: "Performance"),
        ],
      ),
    );
  }

  Padding _button({
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQueryData.fromWindow(window).size.width,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepOrange,
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          )),
        ),
      ),
    );
  }
}
