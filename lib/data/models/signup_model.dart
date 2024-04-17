// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class UserModel {
  final String? name;
  final String? username;
  final String? password;
  final String? email;
  final String? age;

  final String? weight;
  final String? height;
  final String? gender;
  final String? fitnessGoal;
  final String? fitnessLevel;

  UserModel(
      {this.name,
      this.username,
      this.password,
      this.email,
      this.age,
      this.weight,
      this.height,
      this.gender,
      this.fitnessGoal,
      this.fitnessLevel});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'age': age,
      'body_weight': weight,
      'body_height': height,
      'gender': gender,
      'fitness_goal': fitnessGoal,
      'fitness_level': fitnessLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      age: map['age'] as String,
      gender: map['gender'] as String,
      weight: map['body_weight'] as String,
      fitnessGoal: map['fitness_goal'] as String,
      fitnessLevel: map['fitness_level'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserSignupModel {
  final String? name;
  final String? username;
  final String? password;
  final String? email;
  final String? age;
  final String? weight;
  final String? height;
  final String? fitnessGoal;
  final String? fitnessLevel;

  UserSignupModel({
    this.name,
    this.username,
    this.password,
    this.email,
    this.age,
    this.weight,
    this.height,
    this.fitnessGoal,
    this.fitnessLevel,
  });

  // Convert a UserSignupModel instance into a map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'age': age,
      'weight': weight,
      'height': height,
      'fitness_goal': fitnessGoal,
      'fitness_level': fitnessLevel,
    };
  }

  // Construct a UserSignupModel from a map.
  factory UserSignupModel.fromMap(Map<String, dynamic> map) {
    return UserSignupModel(
      name: map['name'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      fitnessGoal: map['fitness_goal'],
      fitnessLevel: map['fitness_level'],
    );
  }
}

class OTPModel {
  final String? email;
  final String? otp;

  OTPModel({
    this.email,
    this.otp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'otp': otp,
    };
  }

  factory OTPModel.fromMap(Map<String, dynamic> map) {
    return OTPModel(
      email: map['email'] as String,
      otp: map['otp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPModel.fromJson(String source) =>
      OTPModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
