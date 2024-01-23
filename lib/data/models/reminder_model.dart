import 'package:flutter/material.dart';

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
}
