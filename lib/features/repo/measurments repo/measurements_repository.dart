import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = await preferences.getString('username');
    try {
      var url = Uri.parse(
          "http://10.0.2.2:8000/measurement/setmeasurement/$username/");

      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add fields to the request
      request.fields['username'] = username!;
      request.fields['bodyweight'] = bodyWeight.toString();
      request.fields['left_arm'] = leftArm.toString();
      request.fields['right_arm'] = rightArm.toString();
      request.fields['left_quadricep'] = leftQuadriceps.toString();
      request.fields['right_quadricep'] = rightQuadriceps.toString();
      request.fields['left_calve'] = leftCalve.toString();
      request.fields['right_calve'] = rightCalve.toString();
      request.fields['chest'] = chest.toString();
      request.fields['left_forearm'] = leftForearm.toString();
      request.fields['right_forearm'] = rightForearm.toString();
      request.fields['waist'] = waist.toString();

      // Send the request and get the response
      var response = await request.send();

      // Check the response and return true if the request was successful
      if (response.statusCode == 201 ||
          (response.statusCode >= 200 && response.statusCode <= 299)) {
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
