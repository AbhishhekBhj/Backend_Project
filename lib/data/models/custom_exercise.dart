class TargetBodyPart {
  final int id;
  final String name;

  TargetBodyPart({
    required this.id,
    required this.name,
  });

  factory TargetBodyPart.fromJson(Map<String, dynamic> json) {
    return TargetBodyPart(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ExerciseType {
  final int id;
  final String name;

  ExerciseType({
    required this.id,
    required this.name,
  });

  factory ExerciseType.fromJson(Map<String, dynamic> json) {
    return ExerciseType(
      id: json['id'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Exercise {
  final int exerciseId;
  final String exerciseName;
  final String exerciseDetails;
  final String? exerciseImage;
  final List<TargetBodyPart> targetBodyPart;
  final ExerciseType type;
  final int caloriesBurnedPerHour;
  final bool addedByUser;
  final String? uploadedBy;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseDetails,
    this.exerciseImage,
    required this.targetBodyPart,
    required this.type,
    required this.caloriesBurnedPerHour,
    required this.addedByUser,
    this.uploadedBy,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      exerciseDetails: json['exercise_details'],
      exerciseImage: json['exercise_image'],
      targetBodyPart: (json['target_body_part'] as List<dynamic>)
          .map((part) => TargetBodyPart.fromJson(part))
          .toList(),
      type: ExerciseType.fromJson(json['type']),
      caloriesBurnedPerHour: json['calories_burned_per_hour'],
      addedByUser: json['added_by_user'],
      uploadedBy: json['uploaded_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'exercise_details': exerciseDetails,
      'exercise_image': exerciseImage,
      'target_body_part': targetBodyPart.map((part) => part.toJson()).toList(),
      'type': type.toJson(),
      'calories_burned_per_hour': caloriesBurnedPerHour,
      'added_by_user': addedByUser,
      'uploaded_by': uploadedBy,
    };
  }
}
