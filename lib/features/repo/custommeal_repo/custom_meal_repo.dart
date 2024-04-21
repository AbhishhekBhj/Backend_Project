import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

import '../../../data/models/custom_meal_model.dart';
import '../../../data/models/food_model.dart';

class CustomMealRepository {
  static Future<CustomMealModel?> getmyCustomMeal() async {
    try {
      var userId = UserDataManager.userData["user_id"];
      var url = ("http://10.0.2.2:8000/api/meals/meal-plans/user/$userId");

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data.containsKey('results')) {
          var mealResults = data['results'];

          // Initialize a new CustomMealModel instance
          var customMealModel = CustomMealModel();

          // Iterate through the meal results
          for (var mealJson in mealResults) {
            var mealType = mealJson["meal_type"];
            var foodsJson = mealJson["foods"] as List<dynamic>;

            // Map the food JSON to FoodModel objects
            var foods = foodsJson
                .map((foodJson) => FoodModel.fromJson(foodJson))
                .toList();

            // Assign the foods to the appropriate list in the CustomMealModel
            switch (mealType) {
              case "Breakfast":
                customMealModel.breakFast = foods;
                break;
              case "Lunch":
                customMealModel.lunch = foods;
                break;
              case "Dinner":
                customMealModel.dinner = foods;
                break;
              case "Snack":
                customMealModel.snacks = foods;
                break;
            }
          }

          return customMealModel;
        }
        // Handle case where 'results' key is missing
        log('No meal results found');
        Fluttertoast.showToast(msg: 'No meal results found');
        return null;
      } else {
        // Handle HTTP error response
        log('Failed to load custom meal: ${response.statusCode}');
        Fluttertoast.showToast(
            msg: 'Failed to load custom meal: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle error
      log('Error: $e');
      Fluttertoast.showToast(msg: 'Error: $e');
      return null;
    }
  }
}
