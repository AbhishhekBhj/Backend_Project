import 'dart:developer';

import 'package:mygymbuddy/data/models/food_model.dart';

class CustomMealModel {
  List<FoodModel>? breakFast;
  List<FoodModel>? lunch;
  List<FoodModel>? dinner;
  List<FoodModel>? snacks;

  CustomMealModel({
    this.breakFast,
    this.lunch,
    this.dinner,
    this.snacks,
  });
  CustomMealModel.fromJson(Map<String, dynamic> json) {
    try {
      // Initialize lists
      breakFast = [];
      lunch = [];
      dinner = [];
      snacks = [];

      // Check if 'results' key exists
      if (json.containsKey('results')) {
        // Iterate over each meal in the results
        (json['results'] as List).forEach((mealJson) {
          String mealType = mealJson['meal_type'];
          List<FoodModel> foods = [];

          // Check if 'foods' key is not null and is a list
          if (mealJson['foods'] != null && mealJson['foods'] is List) {
            // Parse foods for each meal
            (mealJson['foods'] as List).forEach((foodJson) {
              foods.add(FoodModel.fromJson(foodJson));
            });
          }

          // Assign foods to the appropriate meal type
          switch (mealType) {
            case 'Breakfast':
              breakFast = foods;
              break;
            case 'Lunch':
              lunch = foods;
              break;
            case 'Dinner':
              dinner = foods;
              break;
            case 'Snack':
              snacks = foods;
              break;
            default:
              break;
          }
        });
      }
    } catch (e) {
      log('Error parsing custom meal: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (breakFast != null) {
      data['BreakFast'] = breakFast!.map((v) => v.toJson()).toList();
    }
    if (lunch != null) {
      data['Lunch'] = lunch!.map((v) => v.toJson()).toList();
    }
    if (dinner != null) {
      data['Dinner'] = dinner!.map((v) => v.toJson()).toList();
    }
    if (snacks != null) {
      data['Snack'] = snacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CustomMealModel{breakFast: $breakFast, lunch: $lunch, dinner: $dinner, snacks: $snacks}';
  }
}
