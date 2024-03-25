class WorkoutModel {
  final int exerciseId;
  final int username;
  final String? createdAt;
  final String? updatedAt;
  final int sets;
  final int reps;
  final int weight;
  final int volume;

  WorkoutModel({
    required this.exerciseId,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.volume,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      exerciseId: json['exercise_id'],
      username: json['username'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sets: json['sets'],
      reps: json['reps'],
      weight: json['weight'],
      volume: json['volume'],
    );
  }
}
