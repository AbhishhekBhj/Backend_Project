import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/exercise_library/exercise_details.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:provider/provider.dart';

import '../../../data/models/home_model.dart';

class ExerciseLibrary extends StatefulWidget {
  ExerciseLibrary({Key? key}) : super(key: key);

  @override
  _ExerciseLibraryState createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  TextEditingController exerciseController = TextEditingController();
  HomeBloc homeBloc = HomeBloc();

  List<Exercise> exercise = [];

  @override
  void initState() {
    homeBloc.add(HomePageFetchRequiredDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomePageFetchDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomePageFetchDataSuccessState) {
            exercise = state.homeModel.exerciseData;

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Exercise Gallery"),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: GestureDetector(
                  onTap: () {
                    Get.to(ExerciseDetails(
exerciseDetails: exercise[0].exerciseDetails,
                      exerciseImage: exercise[0].exerciseImage,
                      exerciseName: exercise[0].exerciseName,
                      caloriesBurnedPerHour: exercise[0].caloriesBurnedPerHour,
                      targetBodyPart: exercise[0].targetBodyPart,
                    ));
                  },
                  child: Container(
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
                        return Card(
                          shape: CircleBorder(),
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
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text("Exercise Gallery"),
              ),
              body: Container(
                child: Text(state.toString()),
              ));
        });
  }
}
