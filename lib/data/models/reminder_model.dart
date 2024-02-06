import 'package:flutter/material.dart';
import 'dart:convert';

class Reminder {
  final String? username;
  final String? title;
  final String? description;
  final String? dueDate;

  Reminder({
    required this.username,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'title': title,
      'description': description,
      'dueDate': dueDate,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      username: map['username'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: map['dueDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reminder.fromJson(String source) =>
      Reminder.fromMap(json.decode(source));
}
