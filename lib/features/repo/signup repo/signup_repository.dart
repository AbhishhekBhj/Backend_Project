import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SignupRepository {
  static Future<bool> signupUser({
    String? username,
    String? name,
    String? age,
    String? email,
    String? password,
    String? phonenumber,
    XFile? image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://10.0.2.2:8000/signups/"),
      );

      request.fields.addAll({
        'username': username ?? '',
        'password': password ?? '',
        'name': name ?? '',
        'age': age ?? '',
        'email': email ?? '',
      });

      if (image != null) {
        // Convert XFile to File
        var imageFile = File(image.path);
        // Add the image file as a part of the request
        request.files.add(http.MultipartFile(
          'profile_picture',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: '${username}_profilepicture.jpg',
        ));
      }
      var response = await request.send();
      if (response.statusCode >= 200) {
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
