part of 'workout_bloc.dart';

@immutable
sealed class WorkoutEvent {}

class WorkoutInitalEvent extends WorkoutEvent {}

class AddWorkoutEvent extends WorkoutEvent {
  final WorkoutEntry workoutEntry;

  AddWorkoutEvent(this.workoutEntry);
}

class ViewWorkoutHistoryEvent extends WorkoutEvent {}

class GetWorkoutFromServerEvent extends WorkoutEvent {}

class FinishWorkoutEvent extends WorkoutEvent {
  final List<WorkoutModel> workoutEntry;

  FinishWorkoutEvent({required this.workoutEntry});
}

class DeleteWorkoutEvent extends WorkoutEvent {
  final String workoutID;

  DeleteWorkoutEvent({required this.workoutID});
}

class UpdateWorkoutEvent extends WorkoutEvent {
  final WorkoutModel workoutModel;

  UpdateWorkoutEvent({required this.workoutModel});
}

class GetWorkoutHistoryEvent extends WorkoutEvent {}
