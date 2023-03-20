import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class CloudMessageProvider extends ChangeNotifier {
  void _showSnackBar(
    BuildContext context, {
    required String env,
    required String title,
    required String body,
    required String deeplink,
    Color color = Colors.deepOrange,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: DefaultTextStyle(
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                env,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(title),
              Text(body),
              Text(deeplink),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> listener(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message != null) {
        Map<String, dynamic> _data = message.data;
        logger.e("Foreground ::: ${_data["click_action"]}");
        if (message.notification != null) {
          _showSnackBar(
            context,
            env: "Foreground",
            title: message.notification!.title!,
            body: message.notification!.body!,
            deeplink: message.data["click_action"],
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        logger.e("Background ::: ${message.data["click_action"]}");
        if (message.notification != null) {
          _showSnackBar(
            context,
            env: "Background",
            title: message.notification!.title!,
            body: message.notification!.body!,
            deeplink: message.data["click_action"],
            color: Colors.green,
          );
        }
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        logger.e("Terminate ::: ${message.data["click_action"]}");
        if (message.notification != null) {
          _showSnackBar(
            context,
            env: "Terminate",
            title: message.notification!.title!,
            body: message.notification!.body!,
            deeplink: message.data["click_action"],
            color: Colors.deepPurple,
          );
        }
      }
    });
  }

  Future<String?> sendMessageWithAPI() async {
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    if (_fcmToken != null) {
      Future.delayed(const Duration(milliseconds: 5000), () async {
        await _postMessage(_fcmToken);
      });
      return null;
    } else {
      return "FCM Token Empty";
    }
  }

  Future<String?> _postMessage(String fcmToken) async {
    try {
      String _accessToken =
          "ya29.a0AVvZVsrOj8dwN6xc75fOgQhjx1s2ktJSMzthZ4eakH4iC22VnuN6al1yaVGYNF3Px-RkFpOWf5_zf4Fum0V55eEZc-QcGEdlob8ftbmRNapu1pT7wsNate80fimXV4xCZk_LByfZXiycFBh_ha5YPePNHf7-aCgYKAYISARESFQGbdwaIeQ3GPaWb5OmuFKwn3iIJEQ0163";
      http.Response _response = await http.post(
          Uri.parse(
            "https://fcm.googleapis.com/v1/projects/flutter-velog-sample/messages:send",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_accessToken',
          },
          body: json.encode({
            "message": {
              "token": fcmToken,
              "notification": {
                "title": "FCM Test Title",
                "body": "FCM Test Body",
              },
              "data": {
                "click_action": "FCM Test Click Action",
              },
            }
          }));
      if (_response.statusCode == 200) {
        return null;
      } else {
        return "Faliure";
      }
    } on HttpException catch (error) {
      return error.message;
    }
  }
}
