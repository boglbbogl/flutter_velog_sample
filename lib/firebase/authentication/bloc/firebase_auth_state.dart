import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final bool isSocialSignIn;
  const FirebaseAuthState(
      {this.user, this.isLoading = false, this.isSocialSignIn = false});
}

class AuthInitState extends FirebaseAuthState {
  const AuthInitState({super.user, super.isLoading});
  @override
  List<Object?> get props => [user, isLoading];
}

class AuthStateAuthenticated extends FirebaseAuthState {
  const AuthStateAuthenticated(
      {super.user, super.isLoading, super.isSocialSignIn});

  @override
  List<Object?> get props => [user, isLoading, isSocialSignIn];
}

class AuthStateUnAuthenticated extends FirebaseAuthState {
  const AuthStateUnAuthenticated();
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends FirebaseAuthState {
  const AuthStateLoading({super.isLoading});
  @override
  List<Object?> get props => [isLoading];
}

class AuthStatePhoneState extends FirebaseAuthState {
  final String verifycationId;
  const AuthStatePhoneState(this.verifycationId);
  @override
  List<Object?> get props => [verifycationId];
}

class AuthErrorState extends FirebaseAuthState {
  final String errorMessage;
  const AuthErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
