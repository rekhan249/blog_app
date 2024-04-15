// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpModel {
  String? username;
  String? email;
  String? password;
  String? confirmPassoword;
  SignUpModel(
      [this.username, this.email, this.password, this.confirmPassoword]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'confirmPassoword': confirmPassoword,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      map['username'] != null ? map['username'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['password'] != null ? map['password'] as String : null,
      map['confirmPassoword'] != null
          ? map['confirmPassoword'] as String
          : null,
    );
  }
}
