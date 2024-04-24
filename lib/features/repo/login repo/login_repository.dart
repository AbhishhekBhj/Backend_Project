import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginRepository {
  static Future<bool> loginUser({String? username, String? password}) async {
    Map<String, dynamic> userData = {};
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse("http://10.0.2.2:8000/api/users/login/"),
          body: {"username": username, "password": password});

      log('response: ${response.body}');

      Map<String, dynamic> responseData = jsonDecode(response.body);

      String message = responseData['message'];
      String refreshToken = responseData['refresh_token'];
      String accessToken = responseData['access_token'];
      if (message == "invalid credentials") {
        Fluttertoast.showToast(
            msg: "Invalid username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        return false;
      }
      if (message == "Login Successful") {
        log('hey');

        await saveAccessToken(accessToken);
        await saveRefreshToken(refreshToken);
        await SharedPreferenceHelper.saveUserData(responseData['data']);

        log('response data: ${responseData['data']}');

        UserDataManager.userData = await SharedPreferenceHelper.getUserData();

        saveUsername(username);

        log(UserDataManager.userData.toString());

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

class ForgotPasswordRepository {}
