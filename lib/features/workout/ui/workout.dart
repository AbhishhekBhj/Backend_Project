import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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

  bool showAppBar = true;

  void setSelectedExercise(Exercise selectedExercise) {
    setState(() {
      exercise.add(selectedExercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool startedWorkout = workout.length == 0;

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
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: isDarkMode ? Colors.black : Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
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
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,
                        children: [
                          startedWorkout
                              ? Column(
                                  children: [
                                    Text(
                                        "You haven't started a workout yet. Tap the button below to start a workout."),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.to(
                                          ChooseWorkout(
                                            exercise: exercise,
                                            onSelectExercise:
                                                setSelectedExercise,
                                          ),
                                        );
                                      },
                                      child: Text("Start Workout"),
                                    ),
                                    // Display selected exercise(s) here
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: exercise.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                              exercise[index].exerciseName),
                                          // Add more details or actions related to the selected exercise here
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      )),
                ),
              );
            },
          );
        }
      },
    );
  }
}
