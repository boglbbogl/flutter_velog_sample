import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/firebase/fcm/cloud_message_provider.dart';
import 'package:provider/provider.dart';

class FirebaseMessageScreen extends StatelessWidget {
  const FirebaseMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: "Firebase Messaging"),
        body: Center(
          child: GestureDetector(
              onTap: () async {
                HapticFeedback.mediumImpact();
                String? _message;
                _message = await context
                    .read<CloudMessageProvider>()
                    .sendMessageWithAPI();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:
                        _message == null ? Colors.green : Colors.amber,
                    content: Text(
                      _message ?? "Success",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _message == null ? Colors.white : Colors.red,
                      ),
                    )));
              },
              child: const Icon(
                Icons.send_rounded,
                size: 50,
              )),
        ));
  }
}
