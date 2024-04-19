class SignUpModel {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'confirmPassoword': confirmPassword,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) => SignUpModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      confirmPassword: map['confirmPassword']);
}
