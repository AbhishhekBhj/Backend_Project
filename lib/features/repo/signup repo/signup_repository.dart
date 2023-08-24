import 'dart:developer';

import 'package:http/http.dart' as http;

class SignupRepository {
  static Future<bool> signupUser(
      {String? username,
      String? name,
      String? age,
      String? email,
      String? password,
      String? phonenumber}) async {
    var client = http.Client();

    try {
      var response =
          await client.post(Uri.parse("http://10.0.2.2:8000/signup/"), body: {
        'username': username,
        'password': password,
        'name': name,
        'age': age,
        'email': email,
        'phoneNumber': phonenumber,
      });

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
