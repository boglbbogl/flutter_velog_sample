import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DartPatternScreenWithSingleton extends StatelessWidget {
  const DartPatternScreenWithSingleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Singleton Pattern"),
    );
  }
}
