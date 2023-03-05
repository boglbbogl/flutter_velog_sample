import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class FirebaseFirestoreScreen extends StatelessWidget {
  const FirebaseFirestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Firestore"),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              FirebaseFirestore _firestore = FirebaseFirestore.instance;
              await _firestore.collection("cars").doc("123456789").set(
                {
                  "brand": "Genesis",
                  "name": "G90",
                  "price": 12000,
                },
              );
            },
            child: Container(
              width: 100,
              height: 60,
              color: Colors.black,
              child: Center(child: Text("C")),
            ),
          )
        ],
      ),
    );
  }
}
