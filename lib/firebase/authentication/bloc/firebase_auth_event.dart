import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class FirebaseAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckedCurrentUser extends FirebaseAuthEvent {}

class AuthSignOut extends FirebaseAuthEvent {
  final bool isGoogle;
  AuthSignOut(this.isGoogle);
  @override
  List<Object?> get props => [isGoogle];
}

class AuthSignInWithAnonymouse extends FirebaseAuthEvent {}

class AuthSignInWithGoogle extends FirebaseAuthEvent {}

class AuthSignInWithPhoneNumber extends FirebaseAuthEvent {
  final String number;
  AuthSignInWithPhoneNumber(this.number);
  @override
  List<Object?> get props => [number];
}

class AuthPhoneSignInSmsCode extends FirebaseAuthEvent {
  final BuildContext context;
  final String number;
  final String verificationId;

  AuthPhoneSignInSmsCode(this.context, this.number, this.verificationId);
  @override
  List<Object?> get props => [context, number, verificationId];
}

class AuthSignInWithEmailAndPassword extends FirebaseAuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  AuthSignInWithEmailAndPassword(this.context, this.email, this.password);
  @override
  List<Object?> get props => [context, email, password];
}

class AuthSignUpWithEmailAndPassword extends FirebaseAuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  AuthSignUpWithEmailAndPassword(this.context, this.email, this.password);
  @override
  List<Object?> get props => [context, email, password];
}
