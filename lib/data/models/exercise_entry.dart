// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class WorkoutEntry {
  // final String? userName; // to know whose workout data it is
  final DateTime dateTime; //will be used to sort data
  final List<ExerciseEntry> exercises;

  WorkoutEntry(
      {// {required this.userName,
      required this.dateTime,
      required this.exercises});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'userName': userName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'exercises': exercises.map((x) => x.toMap()).toList(),
    };
  }

  factory WorkoutEntry.fromMap(Map<String, dynamic> map) {
    return WorkoutEntry(
      // userName: map['userName'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      exercises: List<ExerciseEntry>.from(
        (map['exercises'] as List<int>).map<ExerciseEntry>(
          (x) => ExerciseEntry.fromMap(x as Map<String, dynamic>),
        ),
      ),
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

  ExerciseEntry(this.exercise, this.sets, this.reps, this.weight);

  toMap() {}

  static fromMap(Map<String, dynamic> x) {}
}
