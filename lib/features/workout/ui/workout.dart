import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/workout/ui/add_set.dart';
import 'package:provider/provider.dart';

import '../../../data/models/home_model.dart';
import '../../../provider/themes/theme_provider.dart';
import '../../home/bloc/home_bloc.dart';
import '../../internet/bloc/bloc/internet_bloc.dart';
import '../../internet/ui/no_internet.dart';
import 'choose_exercise.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({Key? key});

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  late HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
  late InternetBloc internetBloc;

  List<Workout> workout = [];
  List<Exercise> exercise = [];

  List<Exercise> exerciseName = [];
  List<AddSetWidget> addSetWidgetList = [];

  void _showFinishWorkoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Finish Workout"),
          content: Text("Are you sure you want to finish the workout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomePageFetchRequiredDataEvent());
  }

  bool showAppBar = true;

  void setSelectedExercise(Exercise selectedExercise) {
    if (exerciseName.contains(selectedExercise)) {
      Get.snackbar("Error", "Exercise already added");
    } else {
      setState(() {
        exerciseName.add(selectedExercise);
        addSetWidgetList.add(AddSetWidget(
          exerciseName: selectedExercise.exerciseName,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool startedWorkout = exerciseName.length == 0;

    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return NoInternet();
        } else {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomePageFetchDataSuccessState) {
                exercise = state.homeModel.exerciseData;
              }
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  appBar: showAppBar
                      ? AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor:
                              isDarkMode ? Colors.white : Colors.black,
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                      isDarkMode ? Colors.black : Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                      isDarkMode
                                          ? Colors.white
                                          : Colors.blueAccent),
                                ),
                                onPressed: () {
                                  _showFinishWorkoutDialog();
                                },
                                child: Text(
                                  "Finish Workout",
                                ))
                          ],
                          title: Text(
                            "Start Workout",
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.black : Colors.white),
                          ),
                        )
                      : null,
                  body: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          if (notification.scrollDelta! > 0) {
                            setState(() {
                              //user is scrolling down
                              showAppBar = false;
                            });
                          } else if (notification.scrollDelta! < 0) {
                            //user is scrolling up
                            setState(() {
                              showAppBar = true;
                            });
                          }
                        }
                        return true;
                      },
                      child: startedWorkout
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.dumbbell,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.blueAccent,
                                  ),
                                  Text(
                                    "You haven't Started Your Workout Yet",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      log(exercise.toString());
                                      Get.to(
                                        ChooseWorkout(
                                          exercise: exercise,
                                          onSelectExercise: setSelectedExercise,
                                        ),
                                      );
                                    },
                                    child: Text("Start Workout"),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                  vertical: Get.height * 0.03),
                              itemCount: addSetWidgetList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    addSetWidgetList[index],
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          addSetWidgetList.removeAt(index); 
                                          exerciseName.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.blueAccent,
                                        width: Get.width * 0.39,
                                        height: Get.height * 0.065,
                                        child: Center(
                                          child: Text(
                                            "Remove Exercise",
                                            style: TextStyle(
                                                color: isDarkMode
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )),
                  bottomSheet: !startedWorkout
                      ? GestureDetector(
                          onTap: () {
                            Get.to(
                              ChooseWorkout(
                                exercise: exercise,
                                onSelectExercise: setSelectedExercise,
                              ),
                            );
                          },
                          child: Container(
                            width: Get.width * 0.39,
                            height: Get.height * 0.065,
                            color:
                                isDarkMode ? Colors.white : Colors.blueAccent,
                            child: Center(
                              child: Text(
                                "+ Add Exercise",
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              );
            },
          );
        }
      },
    );
  }
}