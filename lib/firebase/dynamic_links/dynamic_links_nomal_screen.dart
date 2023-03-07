import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class DynamicLinksNomalScreen extends StatelessWidget {
  const DynamicLinksNomalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Nomal Dynamic Links"),
    );
  }
}
