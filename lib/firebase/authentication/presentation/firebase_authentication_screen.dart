import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/authentication_type.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/firebase_auth_bloc.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/firebase_auth_event.dart';
import 'package:flutter_velog_sample/firebase/authentication/presentation/firebase_auth_input_screen.dart';
import 'package:flutter_velog_sample/firebase/authentication/bloc/firebase_auth_state.dart';

class FirebaseAuthenticationScreen extends StatelessWidget {
  const FirebaseAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseAuthBloc>(
      create: (context) => FirebaseAuthBloc(),
      child: BlocBuilder<FirebaseAuthBloc, FirebaseAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Firebase Authentication"),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      _title(
                        "User State",
                        color: state.user == null ? Colors.red : Colors.green,
                        size: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.user == null) ...[
                            const Text(
                              "Please Log In !",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                          if (state.user != null) ...[
                            _state("UID", state.user!.uid, context),
                            _state("Name", state.user!.displayName ?? "NULL",
                                context),
                            _state(
                                "Email", state.user!.email ?? "NULL", context),
                            _state("Phone", state.user!.phoneNumber ?? "NULL",
                                context),
                            _state(
                                "Creation Time",
                                "${state.user!.metadata.creationTime ?? 'NUll'}",
                                context),
                            _state(
                                "Last Time",
                                "${state.user!.metadata.lastSignInTime ?? 'NUll'}",
                                context),
                            _state("Is Annoymouse",
                                "${state.user!.isAnonymous}", context),
                            _state("Email Verify",
                                "${state.user!.emailVerified}", context),
                            _state(
                                "Provider",
                                state.user!.providerData.isNotEmpty
                                    ? state.user!.providerData[0].providerId
                                    : "NULL",
                                context),
                          ],
                        ],
                      ),
                      _title("Sign Out"),
                      _button(context: context, event: [
                        AuthSignOut(false),
                        AuthSignOut(true)
                      ], content: [
                        "Firebase",
                        "Google"
                      ], isBlocked: [
                        (state.user == null ||
                            (state.providerState ==
                                SignInProviderState.google)),
                        (state.user == null ||
                            state.providerState != SignInProviderState.google)
                      ]),
                      _title("Sign In"),
                      _button(context: context, event: [
                        AuthSignInWithAnonymouse(),
                        AuthSignInWithGoogle(),
                      ], content: [
                        "Anonymouse",
                        "Google"
                      ], isBlocked: [
                        state.user != null,
                        state.user != null
                      ]),
                      _button(context: context, event: [], content: [
                        "Email And Password",
                        "Phone Number"
                      ], isBlocked: [
                        state.user != null,
                        state.user != null
                      ], onTap: [
                        () =>
                            _pageRoute(context, AuthenticationType.emailSignIn),
                        () =>
                            _pageRoute(context, AuthenticationType.phoneSignIn),
                      ]),
                      _title("Update"),
                      _button(context: context, event: [], content: [
                        "Email",
                        "Password"
                      ], isBlocked: [
                        state.providerState != SignInProviderState.emailVerify,
                        state.providerState != SignInProviderState.emailVerify,
                      ], onTap: [
                        () =>
                            _pageRoute(context, AuthenticationType.updateEmail),
                        () => _pageRoute(
                            context, AuthenticationType.updatePassword),
                      ]),
                      _title("Verification"),
                      _button(context: context, event: [
                        AuthVerifySendEmail(),
                        AuthResetPasswordSendEmail(),
                      ], content: [
                        "Email",
                        "Reset Password"
                      ], isBlocked: [
                        state.providerState !=
                            SignInProviderState.emailUnVerify,
                        state.providerState != SignInProviderState.emailVerify,
                      ]),
                      _title("Sign Up"),
                      _button(context: context, event: [], content: [
                        "Email And Password"
                      ], isBlocked: [
                        state.user != null
                      ], onTap: [
                        () => _pageRoute(context, AuthenticationType.signUp),
                      ])
                    ],
                  ),
                ),
                if (state.isLoading) ...[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.yellow,
                    )),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _pageRoute(BuildContext context, AuthenticationType type) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
              value: context.read<FirebaseAuthBloc>(),
              child: FirebaseAuthInPutScreen(
                type: type,
              ),
            )));
  }

  Padding _state(String title, String content, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: Text(
            content,
            style: const TextStyle(
                color: Color.fromRGBO(215, 215, 215, 1), fontSize: 12),
          )),
        ],
      ),
    );
  }

  Padding _title(
    String title, {
    Color color = Colors.amber,
    double size = 18,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: size, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Padding _button({
    required BuildContext context,
    required List<FirebaseAuthEvent> event,
    required List<String> content,
    required List<bool> isBlocked,
    List<Function()>? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 10,
        children: [
          ...List.generate(
              content.length,
              (index) => IgnorePointer(
                    ignoring: isBlocked[index],
                    child: GestureDetector(
                      onTap: onTap != null
                          ? onTap[index]
                          : () {
                              context
                                  .read<FirebaseAuthBloc>()
                                  .add(event[index]);
                            },
                      child: Container(
                        width: content.length == 1
                            ? size.width
                            : size.width / 2 - 25,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(91, 91, 91, 1),
                        ),
                        child: Center(
                            child: Text(
                          content[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isBlocked[index] ? 12 : 14,
                              color: isBlocked[index]
                                  ? const Color.fromRGBO(155, 155, 155, 1)
                                  : Colors.white),
                        )),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
