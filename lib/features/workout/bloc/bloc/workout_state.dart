part of 'workout_bloc.dart';

@immutable
sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

class WorkoutActionState extends WorkoutState {}

class WorkoutSavingState extends WorkoutState {}

class WorkoutSaveSuccessState extends WorkoutState {}

class WorkoutSaveFailureState extends WorkoutState {}
