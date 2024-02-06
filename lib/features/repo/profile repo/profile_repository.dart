import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class ProfileRepository {
  Future<bool> checkPassword(String? password) async {
    String? accessToken = await getAccessToken();
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse(
              '${baseUrl}password/post/${UserDataManager.userData['username']}/'),
          body: {"password": password},
          headers: {"Authorization": "Bearer $accessToken"});

      Map<String, dynamic> responseData = jsonDecode(response.body);
      var message = responseData['password_match'];

      log(responseData.toString());

      if (message == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> changePassword(String? password) async {
    String? accessToken = await getAccessToken();
    var client = http.Client();
    log(accessToken.toString());
    try {
      var response = await client.post(
          Uri.parse(
              '${baseUrl}password/change/${UserDataManager.userData['username']}/'),
          body: {"password": password},
          headers: {"Authorization": "Bearer $accessToken"});

      Map<String, dynamic> responseData = jsonDecode(response.body);
      var message = responseData['message'];
      log(message);

      if (message == 'Password changed successfully') {
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
