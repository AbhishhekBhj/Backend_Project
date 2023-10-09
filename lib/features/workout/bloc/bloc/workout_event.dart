part of 'workout_bloc.dart';

@immutable
sealed class WorkoutEvent {}

class WorkoutInitalEvent extends WorkoutEvent {}

class AddWorkoutEvent extends WorkoutEvent {
  final WorkoutEntry workoutEntry;

  AddWorkoutEvent(this.workoutEntry);
}

class ViewWorkoutHistoryEvent extends WorkoutEvent {}


