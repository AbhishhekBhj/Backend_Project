import 'package:flutter/material.dart';

class Reminder {
  final String title;
  final String subTitle;
  final TimeOfDay time;

  Reminder({required this.time, required this.title, required this.subTitle});
}
