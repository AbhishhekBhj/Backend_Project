import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../data/models/workout_model.dart';

class WorkoutRepository {
  static Future<List<WorkoutModel>> postWorkout(
      List<WorkoutModel> workoutModel) async {
    var body;
    try {
      var client = http.Client();
      var url = Uri.parse("http://10.0.2.2:8000/api/workout/logworkout/");

      List<Map<String, dynamic>> jsonDataList = workoutModel.map((workout) {
        return {
          "exercise_id": workout.exerciseId.toString(),
          "username": workout.username.toString(),
          "started_at": formatDate(workout.createdAt!),
          "ended_at": formatDate(workout.updatedAt!),
          "created_at": formatDate(workout.createdAt!),
          "updated_at": formatDate(workout.updatedAt!),
          "sets": workout.sets,
          "reps": workout.reps,
          "weight": workout.weight,
          "volume": workout.volume
        };
      }).toList();

      var jsonEncodedBody = jsonEncode(jsonDataList);

      log(jsonEncodedBody.toString() + 'jsonEncodedBody');

      var response = await client.post(
        url,
        body: (jsonEncodedBody),
        headers: {"Content-Type": "application/json"},
      );

      body = jsonDecode(response.body);

      var statusCode = body['status'];

      var message = body['message'];

      if (statusCode == 201) {
        log("Workout posted successfully");
        log(workoutModel.toString());
        return workoutModel;
      } else {
        log(body.toString());
        log(message);
        log(statusCode.toString());
        log("Workout post unsuccessful");
        return [];
      }
    } catch (e) {
      log(body.toString());
      log("Error in postWorkout: $e");
      return [];
    }
  }

  static String formatDate(String date) {
    // Assuming date is already in ISO 8601 format
    DateTime dateTime = DateTime.parse(date);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }
}

class WorkoutHistoryRepository {
  static Future<List<WorkoutModel>> getWorkoutHistory() async {
    try {
      String userID = UserDataManager.userData['user_id'].toString();
      var client = http.Client();

      var url = Uri.parse("http://10.0.2.2:8000/api/workout/getworkout/");

      var response = await client.post(url, body: {"user_id": userID});
      var body = jsonDecode(response.body);
      var statusCode = body['status'];
      var message = body['message'];

      if (statusCode == 200) {
        List<WorkoutModel> workoutHistory = [];
        for (var workout in body['data']) {
          workoutHistory.add(WorkoutModel(
            exerciseId: workout['exercise_id'],
            username: workout['username'],
            createdAt: workout['created_at'],
            updatedAt: workout['updated_at'],
            sets: workout['sets'],
            reps: workout['reps'],
            weight: workout['weight'],
            volume: workout['volume'],
            workoutID: workout['workout_id'],
          ));
        }
        return workoutHistory;
      } else {
        log("Error in getWorkoutHistory: $message");
        return [];
      }
    } catch (e) {
      log("Exception in getWorkoutHistory: $e");
      return [];
    }
  }
}

class DeleteWorkoutObjectRepository {
  static Future<bool> deleteWorkoutObject({required String workoutID}) async {
    try {
      var client = http.Client();
      var url = Uri.parse("http://10.0.2.2:8000/api/workout/deleteworkout/");
      var response = await client.delete(url, body: {"workout_id": workoutID});
      var body = jsonDecode(response.body);
      var statusCode = body['status'];
      var message = body['message'];

      if (statusCode == 200) {
        log("Workout deleted successfully");
        return true;
      } else {
        log("Error in deleteWorkoutObject: $message");
        return false;
      }
    } catch (e) {
      log("Exception in deleteWorkoutObject: $e");
      return false;
    }
  }
}
