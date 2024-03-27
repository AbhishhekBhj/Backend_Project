import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:path/path.dart' as path;

import '../../../data/models/profile_model.dart';

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

  static Future<ProfilePictureUploadResponse> uploadProfilePicture(
      File image) async {
    String? userId = UserDataManager.userData['user_id'].toString();
    String? accessToken = await getAccessToken();

    log(userId!);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}users/uploadprofilephoto/'),
    );

    // Adding the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_picture',
        image.path,
        filename: path.basename(image.path),
      ),
    );

    // Adding other form fields
    request.fields['user_id'] = userId!;

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData.containsKey('data')) {
        var data = responseData['data'];

        if (data.containsKey('profile_picture')) {
          return ProfilePictureUploadResponse( 
            profilePictureUrl: data['profile_picture'],

            status: responseData['status'],
            message: responseData['message'],
          );
        }
      }
    }

    throw Exception('Failed to upload profile picture: ${response.body}');
  }
}
