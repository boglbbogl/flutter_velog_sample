import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class AppToDoScreen extends StatelessWidget {
  const AppToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "To Do"),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
          }),
    );
  }
}
