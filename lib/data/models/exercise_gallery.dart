class ExerciseModel {
  final int id;
  final String exerciseName;
  final String exerciseDetails;
  final String? exerciseImage;
  final double caloriesBurnedPerHour;
  final List<int> targetBodyPart;

  ExerciseModel({
    required this.id,
    required this.exerciseName,
    required this.exerciseDetails,
    required this.exerciseImage,
    required this.caloriesBurnedPerHour,
    required this.targetBodyPart,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      exerciseName: json['exercise_name'],
      exerciseDetails: json['exercise_details'],
      exerciseImage: json['exercise_image'],
      caloriesBurnedPerHour: json['calories_burned_per_hour'].toDouble(),
      targetBodyPart: List<int>.from(json['target_body_part']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise_name': exerciseName,
      'exercise_details': exerciseDetails,
      'exercise_image': exerciseImage,
      'calories_burned_per_hour': caloriesBurnedPerHour,
      'target_body_part': targetBodyPart,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'],
      exerciseName: map['exercise_name'],
      exerciseDetails: map['exercise_details'],
      exerciseImage: map['exercise_image'],
      caloriesBurnedPerHour: map['calories_burned_per_hour'].toDouble(),
      targetBodyPart: List<int>.from(map['target_body_part']),
    );
  }
}
