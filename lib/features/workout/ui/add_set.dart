import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../data/models/home_model.dart';
import '../../../data/models/workout_model.dart';

class AddSetWidget extends StatefulWidget {
  AddSetWidget({
    Key? key,
    required this.exerciseName,
  }) : super(key: key);

  final Exercises exerciseName;

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> {
  final List<WorkoutModel> workoutModel = [];

  void deleteSetObjectCallback(int index) {
    setState(() {
      log("Deleting set object at index $index");
      exerciseSetDetailsList.removeAt(index);
    });
  }

  int initialSet = 0;
  List<ExerciseSetDetails> exerciseSetDetailsList = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Center(
            child: Text(
              widget.exerciseName.exerciseName,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
            width: Get.width * 0.8,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Set"),
                Text("Weight"),
                Text("Reps"),
                Text("Volume"),
                Text("Finish"),
              ],
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < exerciseSetDetailsList.length; i++)
                ExerciseSetDetails(
                  exercise: widget.exerciseName,
                  workoutModel: workoutModel,
                  deleteSetObjectCallback: () => deleteSetObjectCallback(i),
                  initialSet: i + 1,
                ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initialSet++;
                exerciseSetDetailsList.add(ExerciseSetDetails(
                  exercise: widget.exerciseName,
                  workoutModel: workoutModel,
                  initialSet: initialSet,
                  deleteSetObjectCallback: () => deleteSetObjectCallback(
                      exerciseSetDetailsList.length - 1),
                ));
              });
            },
            child: Container(
              color: Colors.blueAccent,
              height: Get.height * 0.05,
              child: const Center(child: Text("+ Add Set")),
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseSetDetails extends StatefulWidget {
  const ExerciseSetDetails({
    Key? key,
    required this.initialSet,
    this.deleteSetObjectCallback,
    required this.exercise,
    required this.workoutModel,
  }) : super(key: key);

  final int initialSet;
  final VoidCallback? deleteSetObjectCallback;
  final Exercises exercise;
  final List<WorkoutModel> workoutModel;

  @override
  State<ExerciseSetDetails> createState() => _ExerciseSetDetailsState();
}

class _ExerciseSetDetailsState extends State<ExerciseSetDetails> {
  int volume = 0;
  int weight = 0;
  int reps = 0;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();

  bool isSetComplete = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: isSetComplete ? const Color(0xffA1EEBD) : Colors.white,
        ),
        width: Get.width * 0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.1,
              child: Center(
                child: Text(widget.initialSet.toString()),
              ),
            ),
            SizedBox(
              width: Get.width * 0.1,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Wt',
                ),
                controller: weightController,
                onChanged: (value) {
                  setState(() {
                    weight = value.isEmpty ? 0 : int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: Get.width * 0.1,
              child: TextFormField(
                controller: repsController,
                decoration: const InputDecoration(
                  labelText: 'Reps',
                ),
                onChanged: (value) {
                  setState(() {
                    reps = value.isEmpty ? 0 : int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: Get.width * 0.1,
              child: Center(
                child: Text("${reps * weight}"),
              ),
            ),
            SizedBox(
              width: Get.width * 0.17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          isSetComplete = !isSetComplete;
                          isSetComplete
                              ? widget.workoutModel.add(WorkoutModel(
                                  exerciseId: widget.exercise.exerciseId,
                                  username: 1,
                                  createdAt: DateTime.now().toString(),
                                  updatedAt: DateTime.now().toString(),
                                  sets: widget.initialSet,
                                  reps: reps,
                                  weight: weight,
                                  volume: reps * weight,
                                ))
                              : widget.workoutModel.removeWhere((element) {
                                  return element.sets == widget.initialSet;
                                });
                          log((widget.workoutModel.toList().toString()));
                        },
                      );
                    },
                    child: Icon(
                      Icons.check,
                      color: isSetComplete ? Colors.blue : Colors.grey,
                    ),
                  ),
                  if (widget.deleteSetObjectCallback != null)
                    GestureDetector(
                      onTap: widget.deleteSetObjectCallback,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
