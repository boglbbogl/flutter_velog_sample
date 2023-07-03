import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class _InfinityScrollModel {
  final int id;
  final String name;
  final Timestamp dateTime;

  _InfinityScrollModel({
    required this.id,
    required this.name,
    required this.dateTime,
  });

  factory _InfinityScrollModel.fromJson(Map<String, dynamic> json) {
    return _InfinityScrollModel(
      id: json["id"],
      name: json["name"],
      dateTime: json["dateTime"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "dateTime": dateTime,
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
  List<_InfinityScrollModel> infinityData = [];
  DocumentSnapshot? lastSnapshot;

  Future<void> _initData() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot = await _firestore
        .collection("infinity_scroll")
        .limit(2)
        .orderBy("dateTime")
        .get();
    setState(() {
      lastSnapshot = _snapshot.docs.last;
      infinityData = _snapshot.docs
          .map((e) => _InfinityScrollModel.fromJson(e.data()))
          .toList();
    });
  }

  Future<void> _infinityScroll() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot = await _firestore
        .collection("infinity_scroll")
        .orderBy("dateTime")
        .startAfterDocument(lastSnapshot!)
        .limit(2)
        .get();
    setState(() {
      lastSnapshot = _snapshot.docs.last;
      infinityData.addAll(_snapshot.docs
          .map((e) => _InfinityScrollModel.fromJson(e.data()))
          .toList());
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Firestore"),
      body: ListView.separated(
        itemCount: infinityData.length,
        itemBuilder: (context, index) {
          return DefaultTextStyle(
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.accents[index % 15]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID : ${infinityData[index].id}"),
                  Text("Rank : ${infinityData[index].name}"),
                  Text("DateTime : ${infinityData[index].dateTime.toDate()}"),
                  if (infinityData.length - 1 == index) ...[
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            await _infinityScroll();
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(91, 91, 91, 1),
            ),
          );
        },
      ),
    );
  }
}
