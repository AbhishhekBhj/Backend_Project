part of 'custommeal_bloc.dart';

@immutable
sealed class CustommealState {}

final class CustommealInitial extends CustommealState {}

final class CustommealLoading extends CustommealState {}

final class CustommealLoaded extends CustommealState {
  final CustomMealModel customMealModel;

  CustommealLoaded(this.customMealModel);
}

final class CustommealError extends CustommealState {
  final String message;

  CustommealError(this.message);
}
