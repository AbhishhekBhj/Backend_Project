import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class LogWaterRepository {
  static Future<bool> logWaterConsumed(
      {required String? username, required dynamic? volume}) async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse("http://10.0.2.2:8000/water/logintake/"), body: {
        "username": username ?? '',
        "volume": '$volume',
        "timestamp": DateTime.now().toString(),
      });
      log(response.body.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
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
