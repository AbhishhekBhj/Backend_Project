import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/food_item.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

class CustomFoodRepository {
  static Future<bool> createCustomFoodItem(
      FoodItem foodItem) async {
    try {
      

      var url = Uri.parse('http://10.0.2.2:8000/api/foods/add_custom_food/');

      var response = await http.post(url, body: {
        'user_id': foodItem.userId,
        'food_name': foodItem.foodName,
        'food_description': foodItem.foodDescription,
        'food_calories_per_serving': foodItem.foodCaloriesPerServing.toString(),
        'food_serving_size': foodItem.foodServingSize.toString(),
        'food_protein_per_serving': foodItem.foodProteinPerServing.toString(),
        'food_carbs_per_serving': foodItem.foodCarbsPerServing.toString(),
        'food_fat_per_serving': foodItem.foodFatPerServing.toString(),
      });

      var decodedResponse = jsonDecode(response.body);
      var status = decodedResponse['status'];
      var message = decodedResponse['message'];

      if (status == 200) {
        return true;
      } else if (status == 400) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
