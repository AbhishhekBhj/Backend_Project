// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mygymbuddy/texts/texts.dart';

class Features {
  final String image;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  Features({
    required this.image,
    required this.title,
    required this.subTitle,
    this.onTap,
  });
  static List<Features> featuresList = [
    Features(
        image: aWorkout,
        title: "Start Workout",
        subTitle: "Start Your Workout",
        onTap: () {}),
    Features(
        image: aCalories,
        title: "Diet Tracker",
        subTitle: "Track Your Calories",
        onTap: () {}),
    Features(
        image: aReminder,
        title: "Reminders",
        subTitle: "Set Reminders",
        onTap: () {}),
    Features(
        image: aGlass,
        title: "Drink Water",
        subTitle: "Add Water Drank",
        onTap: () {}),
    Features(
        image: aBmi,
        title: "BMI",
        subTitle: "Calculate Your BMI",
        onTap: () {}),
    Features(
        image: aTape,
        title: "Measurement",
        subTitle: "Set measurements",
        onTap: () {})
  ];
}
