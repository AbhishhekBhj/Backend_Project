import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/food_model.dart';

class CaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(String? foodName) async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse("http://10.0.2.2:8000/foods/$foodName"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> foodData = json.decode(response.body);

        // Map the list of food data to list of FoodModel
        final List<FoodModel> foodInfo = foodData.map((item) {
          return FoodModel.fromMap(item);
        }).toList();

        return foodInfo;
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
