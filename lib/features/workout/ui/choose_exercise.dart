import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../data/models/home_model.dart';
import '../../../provider/themes/theme_provider.dart';

class ChooseWorkout extends StatefulWidget {
  ChooseWorkout(
      {Key? key, required this.exercise, required this.onSelectExercise});

  final List<Exercises> exercise;
  Function(Exercises) onSelectExercise;

  @override
  State<ChooseWorkout> createState() => _ChooseWorkoutState();
}

class _ChooseWorkoutState extends State<ChooseWorkout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.exercise.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choose Exercise"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        // body: Container(
        //   height: Get.height * 0.5,
        //   color: Colors.red,
        // ),
        body: SizedBox(
          //
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: Get.height * 0.02,
            ),
            padding: const EdgeInsets.all(8),

            // shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
                child: ListTile(
                  trailing: const Icon(Icons.add),
                  leading: const Icon(Icons.fitness_center),
                  title: Text("${widget.exercise[index].exerciseName}"),
                  onTap: () {
                    widget.onSelectExercise(widget.exercise[index]);
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
            itemCount: widget.exercise.length,
          ),
        ));
  }
}
