// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
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
        onTap: () {
          HomeBloc.instance.add(StartWorkoutClickedEvent());
        }),
    Features(
        image: aCalories,
        title: "Diet Tracker",
        subTitle: "Track Your Calories",
        onTap: () {
          HomeBloc.instance.add(DietTrackerClickedEvent());
        }),
    Features(
        image: aReminder,
        title: "Reminders",
        subTitle: "Set Reminders",
        onTap: () {
          HomeBloc.instance.add(RemindersClickedEvent());
        }),
    Features(
        image: aGlass,
        title: "Drink Water",
        subTitle: "Add Water Drank",
        onTap: () {
          HomeBloc.instance.add(DrinkWaterClickedEvent());
        }),
    Features(
        image: aBmi,
        title: "BMI",
        subTitle: "Calculate Your BMI",
        onTap: () {
          HomeBloc.instance.add(BmiClickedEvent());
        }),
    Features(
        image: aTape,
        title: "Measurement",
        subTitle: "Set measurements",
        onTap: () {
          HomeBloc.instance.add(MeasurementsClickedEvent());
        })
  ];
}
