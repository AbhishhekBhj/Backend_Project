import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  static Future<bool> loginUser({String? username, String? password}) async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse("http://10.0.2.2:8000/logins/"),
          body: {"username": username, "password": password});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // await saveUserName(username);4
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username ?? ''); // Save the username
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<void> saveUsername(String? username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username ?? ''); // Save the username
  }
}

class CurrentUserRepository {
  static Future<String> currentUser() async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse("http://10.0.2.2:8000/getcurrentuser/"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);

        // Extract the value of the "current_user" key
        String currentUser = jsonResponse["current_user"];

        return currentUser;
      } else {
        // Handle errors or return a default value
        return "";
      }
    } catch (e) {
      // Handle exceptions
      print("Error: $e");
      return "";
    } finally {
      client.close();
    }
  }
}
