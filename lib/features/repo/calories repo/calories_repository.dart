import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/food_model.dart';

class CaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(
      {String? foodName}) async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse("http://10.0.2.2:8000/foods/$foodName/"));

      print('Response Body: ${response.body}'); // Print the response body

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> foodData = json.decode(response.body);

        // Map the single food data object to a FoodModel
        FoodModel foodInfo = FoodModel.fromMap(foodData);

        
        return [foodInfo]; // Return a list containing the single FoodModel
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}
