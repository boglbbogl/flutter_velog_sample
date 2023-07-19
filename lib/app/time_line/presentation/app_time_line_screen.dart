import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/time_line/presentation/create_time_line_screen.dart';

class AppTimeLineScreen extends StatelessWidget {
  const AppTimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Time Line"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(195, 195, 195, 1),
        ),
        backgroundColor: const Color.fromRGBO(81, 81, 81, 1),
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreateTimeLineScreen()));
        },
      ),
      body: ListView(),
    );
  }
}
