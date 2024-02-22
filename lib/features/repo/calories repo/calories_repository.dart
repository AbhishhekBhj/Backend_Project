import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/calorie_logging_model.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

class CaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(
      {String? foodName}) async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse("http://10.0.2.2:8000/foods/$foodName/"));

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

class CaloriesLogRepository {
  static Future<bool> logCalories({
    CaloriesLog? caloriesLog,
  }) async {
    var client = http.Client();

    var token = await getAccessToken();

    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/calories/logcalories/"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token!}",
        },
        body: jsonEncode(caloriesLog!.toJson()),
      );

      var data = json.decode(response.body);
      log(data.toString());
      var statusCode = data["status"];

      if (statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("${e}error");
      return false;
    } finally {
      client.close();
    }
  }
}

class MultiCaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(
      {String? foodName}) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          "http://10.0.2.2:8000/api/foods/get_food_details/$foodName/"));

      if (response.statusCode == 200) {
        final List<dynamic> foodDataList = json.decode(response.body)['data'];

        // Map each JSON object in the list to a FoodModel
        List<FoodModel> foodInfoList = foodDataList
            .map((foodData) => FoodModel.fromMap(foodData))
            .toList();

        return foodInfoList;
      } else {
        log('Failed to load food data, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error while fetching food data: $e');
      return [];
    } finally {
      client.close();
    }
  }
}
