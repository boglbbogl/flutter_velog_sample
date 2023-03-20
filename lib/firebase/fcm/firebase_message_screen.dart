import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class FirebaseMessageScreen extends StatelessWidget {
  const FirebaseMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Messaging"),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  String? _fcmToken =
                      await FirebaseMessaging.instance.getToken();
                  logger.e(_fcmToken);
                  FirebaseMessaging.instance
                      .sendMessage(
                    to: _fcmToken,
                  )
                      .then((value) {
                    logger.e("value");
                  });
                },
                child: Text("adslkfjkladjsf")),
          )
        ],
      ),
    );
  }
}
