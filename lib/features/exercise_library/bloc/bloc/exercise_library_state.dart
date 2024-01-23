part of 'exercise_library_bloc.dart';

@immutable
sealed class ExerciseLibraryState {}

final class ExerciseLibraryInitial extends ExerciseLibraryState {}

final class ExerciseLibraryLoading extends ExerciseLibraryState {}

final class ExerciseLibraryLoaded extends ExerciseLibraryState {
  final List<ExerciseModel> exerciseGallery;

  ExerciseLibraryLoaded({required this.exerciseGallery});
}

final class ExerciseLibraryError extends ExerciseLibraryState {}
