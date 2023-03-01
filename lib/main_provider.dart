import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/main.dart';

class MainProvider extends ChangeNotifier {
  User? user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void getCurrentUser() {
    User? _user = _firebaseAuth.currentUser;
    user = _user;
    logger.e(_user);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
  }

  Future<void> signInWithEMail(BuildContext context) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
  }

  Future<void> signInWithAnonymous(BuildContext context) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    UserCredential _credential = await _firebaseAuth.signInAnonymously();
    if (_credential.user != null) {
      logger.e(_credential.user!.uid);
    }
  }

  Future<void> signOut(BuildContext context) async {
    HapticFeedback.mediumImpact();
    await _firebaseAuth.signOut();
    user = null;
    Navigator.of(context).pop();
  }
}
