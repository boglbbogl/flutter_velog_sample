import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_velog_sample/app/to_do/model/to_do_model.dart';

class TodoRepository {
  static final TodoRepository instance = TodoRepository._internal();
  factory TodoRepository() => instance;
  TodoRepository._internal();

  Future<List<TodoModel>> readTodoList({
    required String uid,
  }) async {
    QuerySnapshot<Map<String, dynamic>> _snapshot = await FirebaseFirestore
        .instance
        .collection("to_do")
        .limit(2)
        .orderBy("dateTime")
        .get();
    return _snapshot.docs.map((e) => TodoModel.fromJson(e.data())).toList();
  }

  Future<User?> currentUserCheck() async {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      return _user;
    } else {
      return null;
    }
  }

  Future<User?> signInWithAnonymous() async {
    UserCredential _credential =
        await FirebaseAuth.instance.signInAnonymously();
    if (_credential.user != null) {
      return _credential.user;
    } else {
      return null;
    }
  }
}
