part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class CreateCustomFoodClickedEvent extends FoodEvent {
  final FoodItem foodItem;

  CreateCustomFoodClickedEvent({
    required this.foodItem,
  });
}
