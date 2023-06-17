import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class PerformanceListViewScreen extends StatelessWidget {
  final List<String> images;
  const PerformanceListViewScreen({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "List View"),
    );
  }
}
