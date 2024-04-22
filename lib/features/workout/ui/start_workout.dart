import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/exercise_entry.dart';
import 'package:mygymbuddy/features/workout/ui/add_set.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../home/bloc/home_bloc.dart';

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

  List<String> exerciseName = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String selectedExercise = "";
    bool isdarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomePageFetchDataSuccessState) {
          log(state.homeModel.exerciseData.toString());
          exerciseName =
              state.homeModel.exerciseData.map((e) => e.exerciseName).toList();
        }
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
                  DropdownButtonFormField(
                    value: selectedExercise,
                    items: exerciseName.map((exercise) {
                      return DropdownMenuItem(
                        value: exercise,
                        child: Text(exercise),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedExercise = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Exercise',
                    ),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: isdarkMode
                            ? Colors.grey[300]
                            : MyColors.accentPurple,
                        foregroundColor:
                            isdarkMode ? Colors.black : Colors.white),
                    onPressed: () {
                      addExercise();
                    },
                    child: Text('Finish Set'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor:
                            isdarkMode ? Colors.grey[300] : MyColors.accentBlue,
                        foregroundColor:
                            isdarkMode ? Colors.black : Colors.white),
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
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workoutEntries.length,
                      itemBuilder: (context, index) {
                        final entry = workoutEntries[index];
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: themeProvider.getTheme ==
                                          themeProvider.darkTheme
                                      ? Colors.white
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
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
                                  style: TextStyle(
                                      color: isdarkMode
                                          ? Colors.white
                                          : Colors
                                              .black), // Common style for the entire text
                                  children: [
                                    TextSpan(text: 'Sets: ${entry.sets}\n'),
                                    TextSpan(
                                        text: 'Reps: ${entry.reps} reps\n'),
                                    TextSpan(
                                        text: 'Weight: ${entry.weight} kgs\n'),
                                    TextSpan(
                                      text:
                                          'Volume: ${(entry.reps * entry.weight).toStringAsFixed(2)} kgs\n',
                                    ),
                                  ],
                                ),
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
      },
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
}
