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
    logger.e(user);
  }

  Future<void> passwordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> emailVerification() async {
    User? _user = _firebaseAuth.currentUser;
    if (_user != null) {
      await _user.sendEmailVerification();
    }
  }

  Future<void> passwordUpdate() async {
    if (user != null) {
      await user!.updatePassword("123123123");
    }
  }

  Future<void> emailAddressUpdate() async {
    if (user != null) {
      await user!.updateEmail("velogtyger@test.com");
    }
  }

  Future<void> signInWithSmsCode(BuildContext context, String code) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    if (_verificationId != null) {
      PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: code);
      UserCredential _user =
          await _firebaseAuth.signInWithCredential(_phoneCredential);
      if (_user.user != null) {
        user = _user.user;
      }
    }
  }

  String? _verificationId;

  Future<void> signInWithPhoneNumber(
      BuildContext context, String number) async {
    HapticFeedback.mediumImpact();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+82 $number",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {
        showSnackbar(context, "${exception.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
      }
    }
  }

  Future<void> createEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    HapticFeedback.mediumImpact();
    try {
      UserCredential _credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
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
    Navigator.of(context).pop();
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

  Future<void> signInWithEMail(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    HapticFeedback.mediumImpact();
    try {
      UserCredential _credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
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
    Navigator.of(context).pop();
  }

  Future<void> signInWithAnonymous(BuildContext context) async {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    UserCredential _credential = await _firebaseAuth.signInAnonymously();
    if (_credential.user != null) {
      user = _credential.user;
    }
  }

  Future<void> signOut(BuildContext context) async {
    HapticFeedback.mediumImpact();
    await _firebaseAuth.signOut();
    user = null;
    Navigator.of(context).pop();
  }
}
