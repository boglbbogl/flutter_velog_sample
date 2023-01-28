import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class AppCaculatorScreen extends StatelessWidget {
  const AppCaculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Caculator App"),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
