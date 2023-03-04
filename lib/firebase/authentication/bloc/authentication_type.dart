
enum AuthenticationType {
  signUp(true, true),
  emailSignIn(true, true),
  emailVerify(true, false),
  resetPassword(false, true),
  phoneSignIn(false, false);

  final bool isEmail;
  final bool isPassword;
  const AuthenticationType(this.isEmail, this.isPassword);
}
