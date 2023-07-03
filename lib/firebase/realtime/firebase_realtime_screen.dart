import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class _TestModel {
  final int id;
  final int age;
  final String name;

  _TestModel({required this.id, required this.age, required this.name});

  factory _TestModel.fromJson(Map<dynamic, dynamic> json) {
    return _TestModel(
      id: json["id"],
      age: json["age"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "age": age,
      "name": name,
    };
  }
}

class FirebaseRealtimeScreen extends StatefulWidget {
  const FirebaseRealtimeScreen({super.key});

  @override
  State<FirebaseRealtimeScreen> createState() => _FirebaseRealtimeScreenState();
}

class _FirebaseRealtimeScreenState extends State<FirebaseRealtimeScreen> {
  List<_TestModel> _model = [];

  Future<void> _getData() async {
    FirebaseDatabase _realtime = FirebaseDatabase.instance;
    DataSnapshot _snapshot = await _realtime.ref("users").get();
    Map<dynamic, dynamic> _toMap = _snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      _model = _toMap.values.map((e) => _TestModel.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: "Firebase Realtime"),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: index == 0 ? 24 : 0),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.accents[index % 15],
                  fontWeight: FontWeight.bold,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID : ${_model[index].id}"),
                    Text("Age : ${_model[index].age}"),
                    Text("Name : ${_model[index].name}"),
                  ],
                ),
              ),
            );
          },
          itemCount: _model.length,
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Container(
                height: 1,
                color: const Color.fromRGBO(91, 91, 91, 1),
                width: MediaQuery.of(context).size.width,
              ),
            );
          },
        ));
  }
}
