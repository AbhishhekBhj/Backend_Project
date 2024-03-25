import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/log_water_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

class LogWaterRepository {
  static Future<bool> logWaterConsumed({
    required WaterLog waterLog,
  }) async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse("http://10.0.2.2:8000/api/water/log/"), body: {
        "user": waterLog.username.toString(),
        "volume": waterLog.volume.toString(),
        "timestamp": DateTime.now().toString()
      });

      var body = json.decode(response.body);

      var message = body["message"];

      var data = body["data"];

      var statusCode = body["status"];

      if (statusCode == 201 && message == 'Water intake set successfully') {
        saveTodaysWaterIntake(body["data"]["volume"]);

        return true;
      } else {
        log("Failed to log water intake");
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

class GetWaterHistoryDataRepository {
  static Future<List<dynamic>> getWaterHistoryData() async {
    var client = http.Client();
    var username = UserDataManager.userData["username"];
    var token = await getAccessToken();

    try {
      var response = await client.get(
          Uri.parse("http://10.0.2.2:8000/api/water/get/$username/"),
          headers: {"Authorization": "Bearer $token"});

      var body = json.decode(response.body.toString());
      var statusCode = body["status"];
      var message = body["message"];
      var data = body["data"];

      log(data.toString());

      if (statusCode == 200) {
        return data;
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

class DeleteWaterIntakeRepository {
  static Future<bool> deleteWaterIntake({dynamic? intakeID}) async {
    var client = http.Client();

    try {
      var response = await client.delete(
          Uri.parse("http://10.0.2.2:8000/api/water/delete/"),
          body: {"intake_id": intakeID.toString()});

      var data = json.decode(response.body);
      var statusCode = data["status"];
      var message = data["message"];
      var volume = data["water_consumed"];

      if (statusCode == 200 && message == "Water Intake Object Deleted") {
        saveTodaysWaterIntake(volume);
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
