import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../data/models/measurement_model.dart';

class MeasurementsRepository {
  static Future<bool> updateMeasurements({
    BodyMeasurement? bodyMeasurement,
  }) async {
    var client = http.Client();
    String? accessToken = await getAccessToken();
    try {
      var url =
          Uri.parse("http://10.0.2.2:8000/api/measurements/addmeasurement/");

      var response = await client.post(
        url,
        body: jsonEncode(bodyMeasurement!.toMap()),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      );

      log(bodyMeasurement.toMap().toString());
      log(response.body);
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

class MeasurementDataGetRepository {
  static Future<List<BodyMeasurement>> getMeasurements() async {
    var client = http.Client();
    String? accessToken = await getAccessToken();

    var userId = UserDataManager.userData["user_id"];
    var url =
        Uri.parse("http://10.0.2.2:8000/api/measurements/getmeasurement/");
    try {
      var response = await client.post(url, body: {
        "user_id": userId.toString()
      }, headers: {"Authorization": "Bearer $accessToken"});

      log("Token: $accessToken");
      var body = json.decode(response.body.toString());

      log(body.toString());

      var statusCode = body["status"];
      var message = body["message"];

      if (statusCode == 200) {
        List<BodyMeasurement> measurements = [];
        for (var data in body["data"]) {
          measurements.add(BodyMeasurement(
              measurementId: data["measurement_id"],
              height: data["height"],
              weight: data["weight"],
              chestSize: data["chest_size"],
              waistSize: data["waist_size"],
              hipSize: data["hip_size"],
              leftArm: data["left_arm"],
              rightArm: data["right_arm"],
              user: data["user"],
              leftQuadricep: data["left_quadricep"],
              rightQuadricep: data["right_quadricep"],
              leftCalf: data["left_calf"],
              rightCalf: data["right_calf"],
              leftForearm: data["left_forearm"],
              rightForearm: data["right_forearm"],
              notes: data["notes"]));
        }
        return measurements;
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
