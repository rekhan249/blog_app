class SignInModel {
  final String email;
  final String password;

  SignInModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
