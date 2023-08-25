// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// model class for login
class LoginModel {
  final String? username;
  final String? password;
  LoginModel({
    this.username,
    this.password,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
