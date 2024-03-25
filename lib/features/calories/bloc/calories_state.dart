// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calories_bloc.dart';

@immutable
sealed class CaloriesState {}

final class CaloriesInitial extends CaloriesState {}

class CaloriesActionState extends CaloriesState {}

class CaloriesLoadingState extends CaloriesState {}

class CaloriesFetchingState extends CaloriesState {}

class CaloriesFoundSuccessState extends CaloriesState {
  final List<FoodModel> foodModel;
  CaloriesFoundSuccessState({
    required this.foodModel,
  });
}

class CaloriesFoundErrorState extends CaloriesState {}

class CaloriesLoggingLoadingState extends CaloriesState {}

class CaloriesLoggingSuccessState extends CaloriesState {}

class CaloriesLoggingErrorState extends CaloriesState {}

class CaloriesLogDeleteLoadingState extends CaloriesState {}

class CaloriesLogDeleteSuccessState extends CaloriesState {}

class CaloriesLogDeleteErrorState extends CaloriesState {}

class CaloriesIntakeRequestLoadingState extends CaloriesState {}

class CaloriesIntakeRequestSuccessState extends CaloriesState {
  final List<dynamic> caloricIntakeList;
  CaloriesIntakeRequestSuccessState({
    required this.caloricIntakeList,
  });
}

class CaloriesIntakeRequestErrorState extends CaloriesState {}
