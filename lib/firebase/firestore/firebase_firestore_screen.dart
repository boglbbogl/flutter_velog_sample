import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
  Future<List<Test>> _fromCollection() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot =
        await _firestore.collection("read_test").get();
    List<Test> _result =
        _snapshot.docs.map((e) => Test.fromJson(e.data())).toList();
    return _result;
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
      body: FutureBuilder<List<Test>>(
          future: _fromCollection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.accents[index % 15]),
                        child: Column(
                          children: [
                            Text("ID : ${snapshot.data![index].id}"),
                            Text("Name :  ${snapshot.data![index].name}"),
                            Text("Rank : ${snapshot.data![index].name}"),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          }),
    );
  }
}
