import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/signup_model.dart';
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

  static Future<Map<String, dynamic>> getProfileInfo() async {
    try {
      var token = await getAccessToken();
      var client = http.Client();
      var id = UserDataManager.userData['user_id'];
      var url = Uri.parse('${baseUrl}users/getuserdata/');

      var response = await client.post(
        url,
        body: {'user_id': id.toString()},
        headers: {"Authorization": "Bearer $token"},
      );

      var decodedResponse = jsonDecode(response.body);

      var status = decodedResponse['status'];

      if (status == 200) {
        return decodedResponse;
      } else {
        return {'status': status, 'message': 'Failed to get profile info'};
      }
    } catch (e) {
      print('Exception occurred: $e');
      return {'status': -1, 'message': 'Exception occurred: $e'};
    }
  }
}

class EditProfileRepository {
  static Future<bool> editMyProfile(UserModel userModel) async {
    var url = Uri.parse('${baseUrl}users/editprofile/');

    log(url.toString());

    var token = await getAccessToken();

    var userId = UserDataManager.userData['user_id'];

    log(userId.toString());

    var client = http.Client();

    try {
      var response = await http.patch(url, body: {
        "user_id": userId.toString(),
        "name": userModel.name!,
        "age": userModel.age!,
        "weight": userModel.weight!,
        "height": userModel.height,
        "fitness_goal": userModel.fitnessGoal!,
        "fitness_level": userModel.fitnessLevel!,
      }, headers: {
        "Authorization": "Bearer $token"
      });

      var decodedResponse = jsonDecode(response.body);

      log(decodedResponse.toString());

      var status = decodedResponse['status'];

      if (status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: 'Failed to edit profile');
      return false;
    }
  }
}
