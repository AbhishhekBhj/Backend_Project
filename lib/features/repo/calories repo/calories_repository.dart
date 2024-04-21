import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/calorie_logging_model.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var client = http.Client();

    var token = await getAccessToken();

    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/calories/logcalories/"),
        headers: {
          "Authorization": "Bearer ${token!}",
        },
        body: (caloriesLog!.toJson()),
      );

      var data = json.decode(response.body);

      var statusCode = data["status"];

      if (statusCode == 201) {
        List<CaloriesLog> loggedCalories =
            loggedCaloriesFromResponse(data['data']);

        saveTodaysCaloricIntake(
            data['data']['calories_consumed'], data['message']);

        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Error logging calories: ${data['message']}");

        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error logging calories: ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

      log(response.body.toString());

      var data = json.decode(response.body);

      var message = data['message'];

      if (message == "success") {
        final List<dynamic> foodDataList = json.decode(response.body)['data'];
        List<FoodModel> foodInfoList = foodDataList
            .map((foodData) => FoodModel.fromMap(foodData))
            .toList();

        return foodInfoList;
      } else {
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

List<CaloriesLog> loggedCaloriesFromResponse(dynamic responseData) {
  List<CaloriesLog> loggedCalories = [];

  log("Method called");
  if (responseData.containsKey('data')) {
    dynamic data = responseData['data'];

    if (data is List) {
      data.forEach((entry) {
        CaloriesLog calorie = CaloriesLog.fromJson(entry);

        loggedCalories.add(calorie);
      });
    }
  }

  return loggedCalories;
}

class DeleteCaloriesRepository {
  static Future<bool> deleteCalories({dynamic? caloriesId}) async {
    var client = http.Client();

    var token = await getAccessToken();

    try {
      var response = await client.post(
          Uri.parse("http://10.0.2.2:8000/api/calories/deleteintake/"),
          body: {"intake_id": caloriesId.toString()});

      var data = json.decode(response.body);

      var statusCode = data["status"];
      var message = data["message"];
      var caloriesConsumed = data["calories_consumed"];

      if (statusCode == 200 && message == "Caloric Intake Object Deleted") {
        saveTodaysCaloricIntake(caloriesConsumed, message);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      client.close();
    }
  }
}

class GetMyCaloricIntakeRepository {
  static Future<List<dynamic>> getMyCaloricIntake() async {
    var client = http.Client();

    String? accessToken = await getAccessToken();
    var username = UserDataManager.userData['username'];

    log('Username: $username');

    try {
      var response = await client.get(
          Uri.parse(
              "http://10.0.2.2:8000/api/calories/get_calories/$username/"),
          headers: {"Authorization": "Bearer $accessToken"});

      var data = json.decode(response.body.toString());
      var message = data['message'];
      var statusCode = data['status'];
      var responseData = data['data'];

      log('Response data: $responseData');

      if (statusCode == 200) {
        return responseData;
      } else {
        return [];
      }
    } catch (e) {
      log('Error retrieving caloric intake data: $e');
      return [];
    } finally {
      client.close();
    }
  }
}
