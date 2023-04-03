import 'dart:ui';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class FirebaseAnalyticsScreen extends StatelessWidget {
  const FirebaseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<_StandardEvent> _standard = [
      _StandardEvent("Add Cart", () {}),
    ];
    return Scaffold(
      appBar: appBar(title: "Google Analytics"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              runSpacing: 12,
              spacing: 10,
              children: [
                ...List.generate(
                  _standard.length,
                  (index) => _buttonForm(
                    title: _standard[index].title,
                    onTap: _standard[index].onTap,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buttonForm({
    required Function() onTap,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQueryData.fromWindow(window).size.width / 4 - (40 / 4),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(91, 91, 91, 1),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}

class _StandardEvent {
  final String title;
  final Function() onTap;

  const _StandardEvent(this.title, this.onTap);
}
