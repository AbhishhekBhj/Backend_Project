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

class CaloriesLoggingSuccessState extends CaloriesState {
  final String successMessage;

  CaloriesLoggingSuccessState({required this.successMessage});
}

class CaloriesLoggingErrorState extends CaloriesState {
  final String failureMessage;

  CaloriesLoggingErrorState({required this.failureMessage});

}
