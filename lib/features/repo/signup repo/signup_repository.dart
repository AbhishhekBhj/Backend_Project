import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/signup_model.dart';

class SignupRepository {
  static Future<bool> signupUser(UserSignupModel userSignupModel) async {
    try {
      var url = "http://10.0.2.2/api/users/register/";
      var client = http.Client();

      var jsonBody = jsonEncode(
          userSignupModel.toJson()); // Encode userSignupModel to JSON

      var response = await client.post(
        Uri.parse(url),
        body: jsonBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var responseBody = jsonDecode(response.body); // Decode JSON response body
      var message =
          responseBody['message']; // Extract message from response body

      if (message == 'User registered successfully') {
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

class VerifyOtpRepository {
  static Future<bool> verifyOtp(OTPModel otpModel) async {
    try {
      var url = "http://10.0.0.2/api/users/verify_otp/";
      var client = http.Client();

      var jsonBody = jsonEncode(
          otpModel.toJson()); // Ensure body is encoded to JSON string

      var response = await client.post(
        Uri.parse(url),
        body: jsonBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
