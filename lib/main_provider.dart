import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _account = await _googleSignIn.signIn();
    if (_account != null) {
      GoogleSignInAuthentication _authentication =
          await _account.authentication;
      OAuthCredential _googleCredential = GoogleAuthProvider.credential(
        idToken: _authentication.idToken,
        accessToken: _authentication.accessToken,
      );
      UserCredential _credential =
          await _firebaseAuth.signInWithCredential(_googleCredential);
      if (_credential.user != null) {
        user = _credential.user;
        logger.e(user);
      }
    }
  }

  Future<void> createEmailAndPassword(BuildContext context) async {
    try {
      UserCredential _credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: "abcd@abc.kr", password: "1112323");
      if (_credential.user != null) {
        user = _credential.user;
      } else {
        showSnackbar(context, "Server Error");
      }
    } on FirebaseAuthException catch (error) {
      String? _errorCode;
      switch (error.code) {
        case "email-already-in-use":
          _errorCode = error.code;
          break;
        case "invalid-email":
          _errorCode = error.code;
          break;
        case "weak-password":
          _errorCode = error.code;
          break;
        case "operation-not-allowed":
          _errorCode = error.code;
          break;
        default:
          _errorCode = null;
      }
      if (_errorCode != null) {
        showSnackbar(context, _errorCode);
      }
    }
  }

  void showSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.amber,
      content: Text(
        error,
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ));
  }

  Future<void> signInWithEMail(BuildContext context) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    try {
      UserCredential _credential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: "abcd@abc.kr", password: "1112323");
      if (_credential.user != null) {
        user = _credential.user;
      } else {
        showSnackbar(context, "Server Error");
      }
    } on FirebaseAuthException catch (error) {
      String? _errorCode;
      switch (error.code) {
        case "invalid-email":
          _errorCode = error.code;
          break;
        case "user-disabled":
          _errorCode = error.code;
          break;
        case "user-not-found":
          _errorCode = error.code;
          break;
        case "wrong-password":
          _errorCode = error.code;
          break;
        default:
          _errorCode = null;
      }
      if (_errorCode != null) {
        showSnackbar(context, _errorCode);
      }
    }
    // createEmailAndPassword(context);
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
