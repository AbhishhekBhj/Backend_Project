import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/exercise_entry.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class WorkoutLoggingPage extends StatefulWidget {
  const WorkoutLoggingPage({super.key});

  @override
  _WorkoutLoggingPageState createState() => _WorkoutLoggingPageState();
}

class _WorkoutLoggingPageState extends State<WorkoutLoggingPage> {
  TextEditingController exerciseController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  List<ExerciseEntry> workoutEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "START WORKOUT",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: exerciseController,
                decoration: InputDecoration(labelText: 'Exercise'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: setsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Sets'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Reps'),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (kgs)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    foregroundColor: Colors.black),
                onPressed: () {
                  addExercise();
                },
                child: Text('Finish Set'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[200],
                    foregroundColor: Colors.black),
                onPressed: () {
                  log('finished exercise');
                },
                child: Text('Finish Workout'),
              ),
              SizedBox(height: 16),
              Text(
                'Workout Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: workoutEntries.length,
                  itemBuilder: (context, index) {
                    final entry = workoutEntries[index];
                    return ListTile(
                      title: Text(
                        'Exericse: ${entry.exercise.toUpperCase()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      subtitle: Container(
                        alignment: Alignment.centerLeft,
                        width: Get.width * 0.5,
                        child: RichText(
                          text: TextSpan(
                            style:
                                commonTextStyle, // Common style for the entire text
                            children: [
                              TextSpan(text: 'Sets: ${entry.sets}\n'),
                              TextSpan(text: 'Reps: ${entry.reps}\n'),
                              TextSpan(text: 'Weight: ${entry.weight} kgs\n'),
                              TextSpan(
                                text:
                                    'Volume ${(entry.reps * entry.weight).toStringAsFixed(2)} kgs\n',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addExercise() {
    final exercise = exerciseController.text;
    final sets = int.tryParse(setsController.text) ?? 0;
    final reps = int.tryParse(repsController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0.0;

    if (exercise.isNotEmpty && sets > 0 && reps > 0 && weight > 0.0) {
      //create instance to add workout
      final workoutEntry = ExerciseEntry(
          exercise: exercise, sets: sets, weight: weight, reps: reps);
      log(
        exercise,
      );
      final dateTime = DateTime.now();
      setState(() {
        //add the instance in the list
        workoutEntries.add(workoutEntry);

        final workoutData =
            WorkoutEntry(dateTime: dateTime, exercises: workoutEntries);
//convert the data to json
        final jsonData = workoutData.toJson();
        log(jsonData.toString());

        // Clear input fields
        exerciseController.clear();
        setsController.clear();
        repsController.clear();
        weightController.clear();
      });
    }
  }

  TextStyle commonTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
