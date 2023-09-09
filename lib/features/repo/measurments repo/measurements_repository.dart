import 'dart:developer';

import 'package:http/http.dart' as http;

class MeasurementsRepository {
  static Future<bool> updateMeasurements({
    double? bodyWeight,
    double? leftArm,
    double? rightArm,
    double? leftQuadriceps,
    double? rightQuadriceps,
    double? leftCalve,
    double? rightCalve,
    double? chest,
    double? leftForearm,
    double? rightForearm,
    double? waist,
  }) async {
    var client = http.Client();

    try {
      var url = Uri.parse(
          "http://10.0.2.2:8000/measurement/setmeasurement/luckybhaubhau/");

      // Prepare the POST request body with the values and statically set the username
      var body = {
        "username": "luckybhaubhau",
        "bodyweight": bodyWeight,
        "left_arm": leftArm,
        "right_arm": rightArm,
        "left_quadricep": leftQuadriceps,
        "right_quadricep": rightQuadriceps,
        "left_calve": leftCalve,
        "right_calve": rightCalve,
        "chest": chest,
        "left_forearm": leftForearm,
        "right_forearm": rightForearm,
        "waist": waist,
      };

      var response = await client.post(url, body: body);

      // Check the response and return true if the request was successful
      if (response.statusCode == 201) {
        return true;
      } else {
        // Handle other response statuses or errors here
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
