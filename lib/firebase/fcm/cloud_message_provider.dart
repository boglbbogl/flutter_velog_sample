import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';

class CloudMessageProvider extends ChangeNotifier {
  Future<void> listener(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((event) {
      logger.e(event);
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        logger.e(message.data);
      }
    });
  }
}
