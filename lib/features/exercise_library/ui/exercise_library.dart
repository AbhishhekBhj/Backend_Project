import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/exercise_library/exercise_details.dart';

import '../../../functions/exercise.dart';
import 'add_custom_exercise.dart';

class ExerciseLibrary extends StatelessWidget {
  final List<dynamic> exercise;

  const ExerciseLibrary({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Exercise Gallery"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GridView.builder(
          shrinkWrap: true,
          itemCount: exercise.length,
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            final exerciseItem = exercise[index];
            return GestureDetector(
              onTap: () {
                Get.to(ExerciseDetails(
                  exerciseDetails: exerciseItem.exerciseDetails,
                  exerciseImage: exerciseItem.exerciseImage,
                  exerciseName: exerciseItem.exerciseName,
                  caloriesBurnedPerHour: exerciseItem.caloriesBurnedPerHour,
                  targetBodyPart: exerciseItem.targetBodyPart,
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.height * 0.12,
                      height: Get.height * 0.12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      // child: Image.network(
                      //     "http://10.0.2.2:8000${exerciseItem.exerciseImage!}"),
                      child: CachedNetworkImage(
                        imageUrl:
                            'http://10.0.2.2:8000${exerciseItem.exerciseImage!}',
                        placeholder: (context, url) =>
                            Image.asset("assets/img/imageloading.gif"),
                        errorWidget: (context, url, error) => Container(
                            child: Image.asset('assets/img/noimage.png')),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Divider(),
                    Text(exerciseItem.exerciseName!),

                    Text(exerciseItem.exerciseImage!),
                    const SizedBox(height: 10),
                    // Add more details if needed
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
