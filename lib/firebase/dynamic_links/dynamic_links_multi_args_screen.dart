import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DynamicLinksMultiArgsScreen extends StatelessWidget {
  const DynamicLinksMultiArgsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Multi Argument Dynamic Links"),
    );
  }
}
