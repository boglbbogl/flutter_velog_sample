import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class TabViewCustomScreen extends StatelessWidget {
  const TabViewCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Tab View With Custom'),
    );
  }
}
