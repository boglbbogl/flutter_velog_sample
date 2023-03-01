import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> authenticationSheet(BuildContext context) {
  MainProvider _state = context.read<MainProvider>()..getCurrentUser();
  return showModalBottomSheet(
      context: context,
      builder: (secondContext) {
        return Container(
          color: const Color.fromRGBO(71, 71, 71, 1),
          child: SafeArea(
            child: Container(
              height: size.height * 0.45,
              width: size.width,
              color: const Color.fromRGBO(71, 71, 71, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _state.user == null
                                  ? Colors.blue
                                  : const Color.fromRGBO(155, 155, 155, 1),
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _state.signOut(context),
                            child: Text(
                              "Sign Out",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _state.user != null
                                    ? Colors.red
                                    : const Color.fromRGBO(155, 155, 155, 1),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_state.user != null) ...[
                      Column(
                        children: [
                          _userForm("UID", _state.user!.uid),
                          _userForm("E-Mail", _state.user!.email ?? "null"),
                          _userForm("Anonymous", "${_state.user!.isAnonymous}"),
                          _userForm("Creation Time",
                              "${_state.user!.metadata.creationTime}"),
                          _userForm("Last SignIn Time",
                              "${_state.user!.metadata.lastSignInTime}"),
                        ],
                      ),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _signForm(
                            "SignIn With Anonymous",
                            () => _state.signInWithAnonymous(context),
                            _state.user),
                        _signForm("SignIn With E-Mail",
                            () => _state.signInWithEMail(context), _state.user),
                        _signForm(
                            "SignIn With Google",
                            () => _state.signInWithGoogle(context),
                            _state.user),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Padding _userForm(String title, String content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: DefaultTextStyle(
      style: const TextStyle(color: Colors.white, fontSize: 12),
      child: Row(
        children: [
          Text("$title : "),
          Text(content),
        ],
      ),
    ),
  );
}

GestureDetector _signForm(String content, Function() onTap, User? user) {
  return GestureDetector(
    onTap: user == null ? onTap : () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        content,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: user == null
                ? Colors.white
                : const Color.fromRGBO(175, 175, 175, 1)),
      ),
    ),
  );
}
