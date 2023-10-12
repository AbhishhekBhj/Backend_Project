import 'package:flutter/material.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class ExerciseDetails extends StatelessWidget {
  const ExerciseDetails({super.key, required this.exerciseName});
  final String exerciseName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(text: "Exercise Details Page"),
            Center(
              child: Text(
                exerciseName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
