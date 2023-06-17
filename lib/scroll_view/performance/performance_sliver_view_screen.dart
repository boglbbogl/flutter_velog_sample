import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class PerformanceSliverViewScreen extends StatelessWidget {
  final List<String> images;
  const PerformanceSliverViewScreen({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Sliver View"),
    );
  }
}
