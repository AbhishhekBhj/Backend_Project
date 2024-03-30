import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../data/models/custom_exercise.dart';

class ExerciseRepository {
  static Future<Map<String, dynamic>> createCardioExercise(Exercise exercise) async {

    String? username = UserDataManager.userData['username'];
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/exercise/custompost/$username/');

      var exerciseJson = jsonEncode(exercise.toJson());

      var response = await http.post(url, body: exerciseJson);

      var responseData = jsonDecode(response.body);

      if (responseData['status'] == 200) {
        return responseData;
      } else {
        return {
          'status': responseData['status'],
          'message': responseData['message'],
        };
      }
    } catch (e) {
      // Handle any errors
      return {
        'status': 500,
        'message': 'An error occurred. Please try again later.',
      };
    }
  }
}
