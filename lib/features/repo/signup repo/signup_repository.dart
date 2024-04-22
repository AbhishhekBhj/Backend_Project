import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupRepository {
  static Future<bool> signupUser(UserSignupModel userSignupModel) async {
    try {
      log('Signing up user');

      var client = http.Client();

      var body = jsonEncode(userSignupModel.toJson());
      // Encode userSignupModel to JSON
      log('Response: ${body}');

      var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/users/register/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body, // Pass the JSON-encoded string directly
      );

      var responseBody = jsonDecode(response.body); // Decode JSON response body
      var message =
          responseBody['message']; // Extract message from response body

      log('Response: ${responseBody}');
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      if (message == 'User registered successfully') {
        Fluttertoast.showToast(
          msg: 'Signup successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing up: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      log(e.toString());
      return false;
    }
  }
}

class VerifyOtpRepository {
  static Future<bool> verifyOtp(OTPModel otpModel) async {
    try {
      var client = http.Client();

      // Ensure body is encoded to JSON string

      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/users/verify-otp/"),
        body: {
          'email': otpModel.email,
          'otp': otpModel.otp,
        },
      );

      var decodedBody = jsonDecode(response.body); // Decode JSON response body
      var status = decodedBody['status'];
      var message = decodedBody['message'];

      if (status == 200) {
        // Check status from the decoded JSON body
        log('OTP verified successfully');
        return true;
      } else {
        // Handle server-side errors, e.g., invalid OTP
        log('Error: $message');
        return false;
      }
    } catch (e) {
      log('Exception caught: $e');
      return false;
    }
  }
}

class SendOtpRepository {
  static Future<bool> sendOTPToMail(String emailAddress) async {
    try {
      var url = "http://10.0.2.2:8000/api/users/resend-otp/";
      var client = http.Client();

      log('Sending OTP to $emailAddress');

      var response = await client.post(
        Uri.parse(url),
        body: {'email': emailAddress},
      );
      var decodedResponse = jsonDecode(response.body);

      var status = decodedResponse['status'];
      var message = decodedResponse['message'];

      if (status == 200) {
        log('OTP sent successfully');
        return true;
      } else {
        log('Failed to send OTP');
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

class PhotoUploadRepository {
  static Future<bool> uploadPhoto(String imagePath) async {
    try {
      var user = UserDataManager.userData['user_id'];
      var url = "http://10.0.2.2/api/users/uploadprofilephoto/$user";
      var client = http.Client();

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..files.add(
          await http.MultipartFile.fromPath('image', imagePath),
        );

      var response = await client.send(request);
      // Always close the client to avoid resource leaks
      client.close();

      // Decode the response
      var decodedResponse = jsonDecode(await response.stream.bytesToString());

      // Better to check response.statusCode for handling HTTP errors
      if (response.statusCode == 200) {
        var status = decodedResponse['status'];
        var message = decodedResponse['message'];
        var profile_picture = decodedResponse['data']['profile_picture'];

        if (status == 200 &&
            message == 'Profile picture uploaded successfully') {
          UserDataManager.userData['profile_picture'] = profile_picture;
          return true;
        } else {
          return false;
        }
      } else {
        // Handle non-200 responses
        print("Failed to upload photo. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Handle exceptions from the network request
      print("Exception occurred: $e");
      return false;
    }
  }
}

class SendForgotPasswordOtpRepository {}
