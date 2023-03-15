import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class FirebaseStorageScreen extends StatefulWidget {
  const FirebaseStorageScreen({super.key});

  @override
  State<FirebaseStorageScreen> createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  Future<void> _fetchNetworkToFile() async {
    try {
      http.Response _response = await http.get(Uri.parse("uri"));
      if (_response.statusCode == 200) {
        //
      } else {
        //
      }
    } on HttpException catch (error) {
      logger.e(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Storage"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () async {
                logger.e("click");
                _fetchNetworkToFile();
              },
              child: Text("Click")),
        ],
      ),
    );
  }
}
