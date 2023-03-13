import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';

class Test {
  final int id;
  final int rank;
  final String name;

  Test({required this.id, required this.rank, required this.name});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json["id"],
      rank: json["rank"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "rank": rank,
      "name": name,
    };
  }
}

class FirebaseFirestoreScreen extends StatefulWidget {
  const FirebaseFirestoreScreen({super.key});

  @override
  State<FirebaseFirestoreScreen> createState() =>
      _FirebaseFirestoreScreenState();
}

class _FirebaseFirestoreScreenState extends State<FirebaseFirestoreScreen> {
  List<Test> testData = [];

  Future<void> _fromFirestore() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot = await _firestore
        .collection("read_test")
        .orderBy("rank", descending: true)
        .get();
    setState(() {
      testData = _snapshot.docs.map((e) => Test.fromJson(e.data())).toList();
    });
  }

  @override
  void initState() {
    _fromFirestore();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Firestore"),
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: () async {
            FirebaseFirestore _firestore = FirebaseFirestore.instance;
            for (int i = 0; i < 10; i++) {
              await _firestore
                  .collection("read_test")
                  .doc()
                  .set(Test(id: i, rank: i + 1, name: "Tyger $i").toJson());
            }
          },
          child: Container(
            width: 100,
            height: 60,
            color: Colors.black,
            child: const Center(child: Text("CREATE")),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: testData.length,
        itemBuilder: (context, index) {
          return DefaultTextStyle(
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.accents[index % 15]),
            child: Column(
              children: [
                Text("ID : ${testData[index].id}"),
                Text("Name :  ${testData[index].rank}"),
                Text("Rank : ${testData[index].name}"),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              height: 1,
              width: MediaQueryData.fromWindow(window).size.width,
              color: const Color.fromRGBO(91, 91, 91, 1),
            ),
          );
        },
      ),
    );
  }
}
