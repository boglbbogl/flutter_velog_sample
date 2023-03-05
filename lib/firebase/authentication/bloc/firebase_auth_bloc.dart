import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/authentication_type.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/firebase_auth_event.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/firebase_auth_state.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthBloc() : super(const AuthInitState()) {
    on<AuthCheckedCurrentUser>(_checkedCurrentUser);
    on<AuthSignOut>(_signOut);
    on<AuthSignInWithAnonymouse>(_signInWithAnonymouse);
    on<AuthSignInWithGoogle>(_signInWithGoogle);
    on<AuthSignInWithPhoneNumber>(_signInWithPhoneNumber);
    on<AuthPhoneSignInSmsCode>(_phoneSignInSmsCode);
    on<AuthSignInWithEmailAndPassword>(_signInWithEmailAndPassword);
    on<AuthSignUpWithEmailAndPassword>(_signUpWithEmailAndPassword);
    on<AuthChangedEmailUpdate>(_changedEmailUpdate);
    on<AuthChangedPasswordUpdate>(_changedPasswordUpdate);
    on<AuthVerifySendEmail>(_verifySendEmail);
    on<AuthResetPasswordSendEmail>(_resetPasswordSendEmail);
    add(AuthCheckedCurrentUser());
  }

  Future<void> _signOut(
    AuthSignOut event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    await _firebaseAuth.signOut().then((_) {
      emit(const AuthStateUnAuthenticated());
    });
    if (event.isGoogle) {
      await GoogleSignIn().signOut();
    }
  }

  Future<void> _checkedCurrentUser(
    AuthCheckedCurrentUser event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    User? _user = _firebaseAuth.currentUser;
    if (_user != null) {
      SignInProviderState _provider = SignInProviderState.empty;
      if (_user.providerData.isNotEmpty) {
        if (_user.providerData[0].providerId == "google.com") {
          _provider = SignInProviderState.google;
        } else if (_user.providerData[0].providerId == "password") {
          _provider = _user.emailVerified
              ? SignInProviderState.emailVerify
              : SignInProviderState.emailUnVerify;
        }
      }
      emit(AuthStateAuthenticated(user: _user, providerState: _provider));
    } else {
      emit(const AuthStateUnAuthenticated());
    }
  }

  Future<void> _signInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    emit(const AuthStateLoading(isLoading: true));
    HapticFeedback.mediumImpact();
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
        emit(AuthStateAuthenticated(
            user: _credential.user,
            isLoading: false,
            providerState: SignInProviderState.google));
      }
    } else {
      emit(const AuthStateUnAuthenticated());
    }
  }

  Future<void> _signInWithAnonymouse(
    AuthSignInWithAnonymouse event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    emit(const AuthStateLoading(isLoading: true));
    HapticFeedback.mediumImpact();
    UserCredential _credential = await _firebaseAuth.signInAnonymously();
    if (_credential.user != null) {
      emit(AuthStateAuthenticated(
          user: _credential.user,
          isLoading: false,
          providerState: SignInProviderState.empty));
    }
  }

  Future<void> _signInWithPhoneNumber(
    AuthSignInWithPhoneNumber event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    HapticFeedback.mediumImpact();
    Completer<FirebaseAuthState> _state = Completer<FirebaseAuthState>();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+82 ${event.number}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {
        _state.complete(const AuthErrorState("Please Try Again !!"));
      },
      codeSent: (String verificationId, int? resendToken) {
        _state.complete(AuthStatePhoneState(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    emit(await _state.future);
  }

  Future<void> _phoneSignInSmsCode(
    AuthPhoneSignInSmsCode event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    HapticFeedback.mediumImpact();
    try {
      PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.number);
      UserCredential _credential =
          await _firebaseAuth.signInWithCredential(_phoneCredential);
      if (_credential.user != null) {
        emit(AuthStateAuthenticated(
            user: _credential.user,
            isLoading: false,
            providerState: SignInProviderState.empty));
        Navigator.of(event.context)
          ..pop()
          ..pop();
      }
    } on FirebaseException catch (error) {
      logger.e(error.code);
      emit(AuthErrorState(error.message ?? "Server Error"));
    }
  }

  Future<void> _signInWithEmailAndPassword(
    AuthSignInWithEmailAndPassword event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    HapticFeedback.mediumImpact();
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      try {
        UserCredential _credential =
            await _firebaseAuth.signInWithEmailAndPassword(
                email: event.email, password: event.password);
        if (_credential.user != null) {
          emit(AuthStateAuthenticated(
            user: _credential.user,
            providerState: _credential.user!.emailVerified
                ? SignInProviderState.emailVerify
                : SignInProviderState.emailUnVerify,
          ));
          Navigator.of(event.context).pop();
        }
      } on FirebaseException catch (error) {
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
        emit(AuthErrorState(_errorCode ?? "Server Error"));
      }
    } else {
      emit(AuthErrorState(event.email.isEmpty
          ? "Email Empty"
          : event.password.isEmpty
              ? "Password Empty"
              : "Server Error"));
    }
  }

  Future<void> _signUpWithEmailAndPassword(
    AuthSignUpWithEmailAndPassword event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    HapticFeedback.mediumImpact();
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      try {
        UserCredential _credential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: event.email, password: event.password);
        if (_credential.user != null) {
          emit(AuthStateAuthenticated(
            user: _credential.user,
            providerState: SignInProviderState.emailUnVerify,
          ));
          Navigator.of(event.context).pop();
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
        emit(AuthErrorState(_errorCode ?? "Server Error"));
      }
    } else {
      emit(AuthErrorState(event.email.isEmpty
          ? "Email Empty"
          : event.password.isEmpty
              ? "Password Empty"
              : "Server Error"));
    }
  }

  Future<void> _verifySendEmail(
    AuthVerifySendEmail event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    HapticFeedback.mediumImpact();
    if (state.user != null) {
      await state.user!.sendEmailVerification().then((_) {
        emit(const AuthStateUnAuthenticated());
      });
    }
  }

  Future<void> _resetPasswordSendEmail(
    AuthResetPasswordSendEmail event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    if (state.user != null) {
      HapticFeedback.mediumImpact();
      await _firebaseAuth.sendPasswordResetEmail(email: state.user!.email!);
    }
  }

  Future<void> _changedPasswordUpdate(
    AuthChangedPasswordUpdate event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    if (state.user != null) {
      try {
        await state.user!.updatePassword(event.password).then((_) {
          User? _updateUser = _firebaseAuth.currentUser;
          if (_updateUser != null) {
            emit(AuthStateAuthenticated(
                user: _updateUser,
                providerState: _updateUser.emailVerified
                    ? SignInProviderState.emailVerify
                    : SignInProviderState.emailUnVerify));
          } else {
            emit(const AuthStateUnAuthenticated());
          }
          Navigator.of(event.context).pop();
        });
      } on FirebaseException catch (error) {
        String? _errorCode;
        switch (error.code) {
          case "invalid-verification-code":
            _errorCode = error.code;
            break;
          case "invalid-verification-id":
            _errorCode = error.code;
            break;
          default:
            _errorCode = null;
        }
        emit(AuthErrorState(_errorCode ?? "Server Error"));
      }
    }
  }

  Future<void> _changedEmailUpdate(
    AuthChangedEmailUpdate event,
    Emitter<FirebaseAuthState> emit,
  ) async {
    if (state.user != null) {
      try {
        await state.user!.updateEmail(event.email).then((_) {
          User? _updateUser = _firebaseAuth.currentUser;
          if (_updateUser != null) {
            emit(AuthStateAuthenticated(
                user: _updateUser,
                providerState: _updateUser.emailVerified
                    ? SignInProviderState.emailVerify
                    : SignInProviderState.emailUnVerify));
          } else {
            emit(const AuthStateUnAuthenticated());
          }
          Navigator.of(event.context).pop();
        });
      } on FirebaseException catch (error) {
        String? _errorCode;
        switch (error.code) {
          case "invalid-email":
            _errorCode = error.code;
            break;
          case "email-already-in-use":
            _errorCode = error.code;
            break;
          case "requires-recent-login":
            _errorCode = error.code;
            break;

          default:
            _errorCode = null;
        }
        emit(AuthErrorState(_errorCode ?? "Server Error"));
      }
    }
  }

  @override
  void onChange(Change<FirebaseAuthState> change) {
    super.onChange(change);
    logger.e(change);
  }

  @override
  void onTransition(
      Transition<FirebaseAuthEvent, FirebaseAuthState> transition) {
    super.onTransition(transition);
    logger.e(transition);
  }
}
