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
