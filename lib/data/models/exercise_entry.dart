import 'dart:convert';

class WorkoutEntry {
  final DateTime dateTime; // will be used to sort data
  final List<ExerciseEntry> exercises;

  WorkoutEntry({
    required this.dateTime,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'exercises': exercises.map((x) => x.toMap()).toList(),
    };
  }

  factory WorkoutEntry.fromMap(Map<String, dynamic> map) {
    return WorkoutEntry(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      exercises: (map['exercises'] as List)
          .map((x) => ExerciseEntry.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutEntry.fromJson(String source) =>
      WorkoutEntry.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ExerciseEntry {
  final String exercise;
  final int sets;
  final int reps;
  final double weight;

  ExerciseEntry({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }

  factory ExerciseEntry.fromMap(Map<String, dynamic> map) {
    return ExerciseEntry(
      exercise: map['exercise'] as String,
      sets: map['sets'] as int,
      reps: map['reps'] as int,
      weight: map['weight'] as double,
    );
  }
}
