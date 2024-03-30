part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {}

final class FoodUploadLoading extends FoodState {}

final class FoodUploadSuccess extends FoodState {

 
}

final class FoodUploadFailure extends FoodState {
  final String errorMessage;

  FoodUploadFailure({
    required this.errorMessage,
  });
}
