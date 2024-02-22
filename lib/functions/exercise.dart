import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 0,adapterName: "ExerciseAdapter")
class Exercise {
  @HiveField(0)
  final int exerciseId;

  @HiveField(1)
  final String exerciseName;

  @HiveField(2)
  final String exerciseDetails;

  @HiveField(3)
  final String? exerciseImage;

  @HiveField(4)
  final int type;

  @HiveField(5)
  final List<int> targetBodyPart;

  @HiveField(6)
  final int caloriesBurnedPerHour;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseDetails,
    required this.exerciseImage,
    required this.type,
    required this.targetBodyPart,
    required this.caloriesBurnedPerHour,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      exerciseDetails: json['exercise_details'],
      exerciseImage: json['exercise_image'] ?? '',
      type: json['type'],
      targetBodyPart: List<int>.from(json['target_body_part']),
      caloriesBurnedPerHour: json['calories_burned_per_hour'],
    );
  }

  Object? toJson() {}
}
