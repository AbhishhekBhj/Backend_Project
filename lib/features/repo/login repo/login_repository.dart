import 'dart:developer';

import 'package:http/http.dart' as http;

class LoginRepository {
  static Future<bool> loginUser({String? username, String? password}) async {
    var client = http.Client();

    try {
      var response = await client.post(Uri.parse("http://10.0.2.2:8000/login/"),
          body: {"username": username, "password": password});
      if (response.statusCode >= 200 && response.statusCode < 300) {
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
