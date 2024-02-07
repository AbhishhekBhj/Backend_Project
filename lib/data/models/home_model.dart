class Exercise {
  final int exerciseId;
  final String exerciseName;
  final String exerciseDetails;
  final String? exerciseImage;
  final int type;
  final List<int> targetBodyPart;
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

  static fromMap(Exercise exerciseData) {}
}

class Workout {
  final String workoutId;
  final String startedAt;
  final String endedAt;
  final String createdAt;
  final String updatedAt;
  final int sets;
  final int reps;
  final int weight;
  final int volume;
  final int exerciseId;
  final int username;

  Workout({
    required this.workoutId,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.volume,
    required this.exerciseId,
    required this.username,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      workoutId: json['workout_id'],
      startedAt: json['started_at'],
      endedAt: json['ended_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sets: json['sets'],
      reps: json['reps'],
      weight: json['weight'],
      volume: json['volume'],
      exerciseId: json['exercise_id'],
      username: json['username'],
    );
  }
}

class WaterIntake {
  final int user;
  final String timestamp;
  final double volume;

  WaterIntake({
    required this.user,
    required this.timestamp,
    required this.volume,
  });

  factory WaterIntake.fromJson(Map<String, dynamic> json) {
    return WaterIntake(
      user: json['user'],
      timestamp: json['timestamp'],
      volume: json['volume'].toDouble(),
    );
  }
}

class Reminder {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String createdAt;
  final String updatedAt;
  final bool isActive;
  final int user;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.user,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isActive: json['is_active'],
      user: json['user'],
    );
  }
}

class HomeModel {
  final List<Exercise> exerciseData;
  final Map<String, dynamic> workoutData;
  final Map<String, dynamic> waterIntakeData;
  final Map<String, dynamic> reminderData;
  final Map<String, dynamic> measurementData;

  HomeModel({
    required this.exerciseData,
    required this.workoutData,
    required this.waterIntakeData,
    required this.reminderData,
    required this.measurementData,

  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      exerciseData: List<Exercise>.from(
        json['data']['exercise_data']
            .map((exercise) => Exercise.fromJson(exercise)),
      ),
      workoutData: json['data']['workout_data'],
      waterIntakeData: json['data']['water_intake_data'],
      reminderData: json['data']['reminder_data'],
      measurementData: json['data']['measurement_data'],
    );
  }
}

class HomeResponse {
  final int status;
  final HomeModel data;

  HomeResponse({
    required this.status,
    required this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'],
      data: HomeModel.fromJson(json),
    );
  }
}
