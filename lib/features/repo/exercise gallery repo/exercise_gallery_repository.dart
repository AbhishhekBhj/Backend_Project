import "dart:convert";

import "package:http/http.dart" as http;
import "dart:developer";

import "package:mygymbuddy/data/models/exercise_gallery.dart";

class ExerciseGalleryRepository {
  static Future<List<ExerciseModel>> getExerciseGallery() async {
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse("http://10.0.2.2:8000/exercisegallery/getexercise/"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> exerciseData = json.decode(response.body);

        // Map the list of exercise data objects to a list of ExerciseModel
        List<ExerciseModel> exerciseGallery =
            exerciseData.map((e) => ExerciseModel.fromMap(e)).toList();

        return exerciseGallery;
      } else {
        log("No data in backend");
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
