import 'package:flutter/material.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class ExerciseDetails extends StatelessWidget {
  const ExerciseDetails({
    Key? key,
    required this.exerciseName,
    required this.exerciseDetails,
    required this.exerciseImage,
    required this.caloriesBurnedPerHour,
    required this.targetBodyPart,
  }) : super(key: key);

  final String exerciseName;
  final String exerciseDetails;
  final String? exerciseImage;
  final int caloriesBurnedPerHour;
  final List<int> targetBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: (exerciseImage != null)
                  ? Image.network(
                      'http:127.0.0.1:8000$exerciseImage!',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      splashIcon,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerciseDetails,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Calories Burned per Hour: $caloriesBurnedPerHour',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Target Body Part: ${getTargetBodyPartNames()}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTargetBodyPartNames() {
    return targetBodyPart.map((id) => getBodyPartName(id)).join(", ");
  }

  String getBodyPartName(int id) {
    // Assuming you have a mapping from ID to body part name
    Map<int, String> bodyPartMapping = {
      1: "Front Deltoids",
      2: "Rear Deltoids",
      3: "Quadriceps",
      4: "Hamstrings",
      5: "Glutes",
      6: "Lower Back",
      7: "Lats",
      8: "Chest",
      9: "Forearms",
    };
    return bodyPartMapping[id] ?? "Unknown";
  }
}
