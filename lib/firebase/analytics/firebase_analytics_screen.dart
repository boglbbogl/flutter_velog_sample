import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class FirebaseAnalyticsScreen extends StatelessWidget {
  const FirebaseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: "Google Analytics"),
        body: const Center(
          child: Text(
            "GA",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 100,
                color: Colors.amber),
          ),
        ));
  }
}
