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
  

  UserModel( 
      {this.name,
      this.username,
      this.password,
      this.email,
      this.age,
      this.weight, this.height, this.gender, this.fitnessGoal,});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'age': age,
      'body_weight': weight,
      'body_height':height,
      'gender':gender,
      'fitness_goal':fitnessGoal,


      

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      age: map['age'] as String,
      gender:map['gender'] as String,
      weight:map['body_weight'] as String,
      fitnessGoal:map['fitness_goal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
