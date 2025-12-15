class SignUpModel {
  String fullName;
  String email;
  String password;
  String confirmPassword;
  bool agreeToTerms;

  SignUpModel({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.agreeToTerms = false,
  });
}
