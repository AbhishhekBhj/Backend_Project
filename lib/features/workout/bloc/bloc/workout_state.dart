part of 'workout_bloc.dart';

@immutable
sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutPostLoadingState extends WorkoutState {}

final class WorkoutPostLoadedSuccessState extends WorkoutState {}

final class WorkoutPostLoadedErrorState extends WorkoutState {}

class WorkoutHistoryLoadingState extends WorkoutState {}

class WorkoutHistoryLoadedState extends WorkoutState {
  final List<dynamic> workoutHistory;

  WorkoutHistoryLoadedState({required this.workoutHistory});
}

class WorkoutHistoryErrorState extends WorkoutState {
  final String errorMessage;

  WorkoutHistoryErrorState({required this.errorMessage});
}

class WorkoutDataDeleteLoadingEvent extends WorkoutState {}

class WorkoutDataDeleteSuccessEvent extends WorkoutState {}

class WorkoutDataDeleteErrorEvent extends WorkoutState {}
