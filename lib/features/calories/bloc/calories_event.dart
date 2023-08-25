// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calories_bloc.dart';

@immutable
sealed class CaloriesEvent {}

class CaloriesInitalEvent extends CaloriesEvent {}

class CaloriesSearchByNameEvent extends CaloriesEvent {
  final FoodModel foodModel;
  CaloriesSearchByNameEvent({
    required this.foodModel,
  });
}

class CaloriesSearchAllEvent extends CaloriesEvent {
  final FoodModel foodModel;
  CaloriesSearchAllEvent({
    required this.foodModel,
  });
}
