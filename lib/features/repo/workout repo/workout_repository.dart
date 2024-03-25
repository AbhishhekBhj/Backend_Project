import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../data/models/workout_model.dart';

class WorkoutRepository {
  static Future<List<WorkoutModel>> postWorkout(
      List<WorkoutModel> workoutModel) async {
    try {
      var client = http.Client();

      var url = Uri.parse("http://10.0.2.2:8000/api/workout/logworkout/");

      var jsonEncodedBody = jsonEncode(workoutModel);

      var response = await client.post(url,
          body: jsonEncodedBody, headers: {"Content-Type": "application/json"});

      var body = jsonDecode(response.body);

      var statusCode = body['status'];

      var message = body['message'];

      if (statusCode == 201) {
        return workoutModel;
      } else {
        return [];
      }
    } catch (e) {
      log("Error in postWorkout: $e");
      return [];
    }
  }
}
