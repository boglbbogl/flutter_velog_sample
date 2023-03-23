import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ClosedAppFlutterScreen extends StatelessWidget {
  const ClosedAppFlutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Closed App With Flutter"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Platform.isIOS ? "IOS" : "Android",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                if (Platform.isIOS) {
                  exit(0);
                } else {
                  SystemNavigator.pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: Text(
                  "Closed App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
