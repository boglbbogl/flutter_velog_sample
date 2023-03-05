enum AuthenticationType {
  signUp(true, true),
  emailSignIn(true, true),
  updateEmail(true, false),
  updatePassword(false, true),
  resetPassword(false, true),
  phoneSignIn(false, false);

  final bool isEmail;
  final bool isPassword;
  const AuthenticationType(this.isEmail, this.isPassword);
}

enum SignInProviderState {
  emailVerify,
  emailUnVerify,
  google,
  empty;
}
