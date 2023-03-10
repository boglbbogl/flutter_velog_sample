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
  Stream<QuerySnapshot> _fromFirestore() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return _firestore.collection("read_test").snapshots();
    // return
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Firestore"),
      // bottomNavigationBar: SafeArea(
      //   child: GestureDetector(
      //     onTap: () async {
      //       FirebaseFirestore _firestore = FirebaseFirestore.instance;
      //       for (int i = 0; i < 10; i++) {
      //         await _firestore
      //             .collection("read_test")
      //             .doc()
      //             .set(Test(id: i, rank: i + 1, name: "Tyger $i").toJson());
      //       }
      //     },
      //     child: Container(
      //       width: 100,
      //       height: 60,
      //       color: Colors.black,
      //       child: const Center(child: Text("CREATE")),
      //     ),
      //   ),
      // ),
      // body: StreamBuilder<Stream<QuerySnapshot>>(
      //     stream: _fromFirestore(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return ListView.separated(
      //           itemCount: snapshot.data!.length,
      //           itemBuilder: (context, index) {
      //             return DefaultTextStyle(
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.accents[index % 15]),
      //               child: Column(
      //                 children: [
      //                   Text("ID : ${snapshot.data![index].id}"),
      //                   Text("Name :  ${snapshot.data![index].rank}"),
      //                   Text("Rank : ${snapshot.data![index].name}"),
      //                 ],
      //               ),
      //             );
      //           },
      //           separatorBuilder: (BuildContext context, int index) {
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 12),
      //               child: Container(
      //                 height: 1,
      //                 width: MediaQueryData.fromWindow(window).size.width,
      //                 color: const Color.fromRGBO(91, 91, 91, 1),
      //               ),
      //             );
      //           },
      //         );
      //       } else if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: Colors.amber,
      //           ),
      //         );
      //       } else {
      //         return Container(
      //           color: Colors.red,
      //         );
      //       }
      //     }),
    );
  }
}
