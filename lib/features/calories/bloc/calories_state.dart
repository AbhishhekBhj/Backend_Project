part of 'calories_bloc.dart';

@immutable
sealed class CaloriesState {}

final class CaloriesInitial extends CaloriesState {}

class CaloriesActionState extends CaloriesState {}

class CaloriesLoadingState extends CaloriesState {}

class CaloriesFoundSuccessState extends CaloriesState {}

class CaloriesFoundErrorState extends CaloriesState {}

class CaloriesAllFoundSuccessState extends CaloriesState {}
