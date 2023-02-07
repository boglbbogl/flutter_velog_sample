import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class LibraryEquatableScreen extends StatelessWidget {
  const LibraryEquatableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Equatable Library"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _stateUI(context: context, title: "Get X"),
          _stateUI(context: context, title: "Provider"),
          _stateUI(context: context, title: "Bloc"),
        ],
      ),
    );
  }

  Padding _stateUI({
    required BuildContext context,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48, left: 20, right: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Row(
              children: [
                _button(title: "+1", onTap: () {}),
                const SizedBox(width: 12),
                _button(title: "Reset", onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _button({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(115, 115, 115, 1),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
