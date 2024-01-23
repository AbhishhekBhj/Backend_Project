import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/exercise_gallery.dart';
import 'package:mygymbuddy/features/exercise_library/bloc/bloc/exercise_library_bloc.dart';
import 'package:mygymbuddy/features/exercise_library/exercise_details.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class ExerciseLibrary extends StatefulWidget {
  ExerciseLibrary({Key? key}) : super(key: key);

  @override
  _ExerciseLibraryState createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  TextEditingController exerciseController = TextEditingController();
  ExerciseLibraryBloc exerciseLibraryBloc = ExerciseLibraryBloc();

  List<ExerciseModel> exercise = [];

  @override
  void initState() {
    exerciseLibraryBloc.add(ExerciseGalleryFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    return BlocBuilder<ExerciseLibraryBloc, ExerciseLibraryState>(
        bloc: exerciseLibraryBloc,
        builder: (context, state) {
          if (state is ExerciseLibraryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExerciseLibraryLoaded) {
            exercise = state.exerciseGallery;

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Exercise Gallery"),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: exercise.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            ExerciseDetails(
                              exerciseName: exercise[index].exerciseName,
                              exerciseDetails: exercise[index].exerciseDetails,
                              exerciseImage: exercise[index].exerciseImage,
                              caloriesBurnedPerHour:
                                  exercise[index].caloriesBurnedPerHour,
                              targetBodyPart: exercise[index].targetBodyPart,
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(image: AssetImage(aWorkout)),
                              Text(exercise[index].exerciseName),
                              const SizedBox(height: 10),
                              // Add more details if needed
                              // You can also display the image here if available
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
