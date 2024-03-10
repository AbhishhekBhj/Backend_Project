import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

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

class OTPVerifyRepository {
  static Future<String> verifyOTP(OTPModel otpModel) async {
    try {
      var url = "http://10.0.0.2/api/users/verify_otp/";
      var client = http.Client();

      var jsonBody = jsonEncode(otpModel.toJson());
      var respone = await client.post(
        Uri.parse(url),
        body: jsonBody,
      );

      var decodedResponse = jsonDecode(respone.body);
      var status = decodedResponse['status'];
      var message = decodedResponse['message'];
      var data = decodedResponse['data'];
      if (status == 200 && message == 'OTP verified successfully') {
        return 'OTP verified successfully';
      } else if (status == 400 &&
          message == "Something went wrong" &&
          data == "invalid otp") {
        return 'Invalid OTP';
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
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

class SendOtpRepository {
  static Future<bool> sendOTPToMail(String emailAddress) async {
    try {
      var url = "http://10.0.0.2/api/users/resend-otp/";
      var client = http.Client();

      var response = await client.post(
        Uri.parse(url),
        body: jsonEncode({'email': emailAddress}),
      );
      var decodedResponse = jsonDecode(response.body);

      var status = decodedResponse['status'];
      var message = decodedResponse['message'];

      if (status == '200' && message == 'OTP sent successfully') {
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
