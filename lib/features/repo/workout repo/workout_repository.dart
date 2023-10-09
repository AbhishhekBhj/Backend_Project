import 'package:dio/dio.dart';
import 'dart:developer';

class WorkoutRepository {
  static Future<bool> postWorkout(
    String? username,
    String? exerciseName,
    String? sets,
    String? reps,
    String? volume,
  ) async {
    var dio = Dio();

    try {
      var url = "http://10.0.2.2:8000/workout/postworkout/";

      FormData formData = FormData.fromMap({
        'username': username!,
        'exerciseName': exerciseName!,
        'sets': sets!,
        'reps': reps!,
        'volume': volume!
      });

//make a post request

      var response = await dio.post(url, data: formData);

      if (response.statusCode == 201 ||
          (response.statusCode! >= 200 && response.statusCode! <= 299)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
