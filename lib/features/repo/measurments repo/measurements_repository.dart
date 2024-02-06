import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeasurementsRepository {
  static Future<bool> updateMeasurements({
    required double height,
    required double weight,
    required double chestSize,
    required double waistSize,
    required double hipSize,
    required double leftArm,
    required double rightArm,
    required double leftQuadricep,
    required double rightQuadricep,
    required double leftCalf,
    required double rightCalf,
    required double leftForearm,
    required double rightForearm,
    required String notes,
  }) async {
    var client = http.Client();
    String? accessToken = await getAccessToken();
    var userId = UserDataManager.userData['user_id'];
    try {
      var url = Uri.parse(
          "http://10.0.2.2:8000/api/measurements/addmeasurement/$userId/");

      var body = {
        "height": height,
        "weight": weight,
        "chest_size": chestSize,
        "waist_size": waistSize,
        "hip_size": hipSize,
        "left_arm": leftArm,
        "right_arm": rightArm,
        "left_quadricep": leftQuadricep,
        "right_quadricep": rightQuadricep,
        "left_calf": leftCalf,
        "right_calf": rightCalf,
        "left_forearm": leftForearm,
        "right_forearm": rightForearm,
        "notes": notes,
      };

      var response = await client.post(
        url,
        body: body,
        headers: {"Authorization": "Bearer $accessToken"},
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      var message = responseData['message'];

      if (message == 'Measurement added successfully') {
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
