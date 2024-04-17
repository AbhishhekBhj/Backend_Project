// import "dart:convert";
// import "dart:developer";

// import "package:http/http.dart" as http;
// import "package:mygymbuddy/functions/shared_preference_functions.dart";

// class MakeMeProMemberRepository {
//   static Future<Map<String, dynamic>> makeMeProMember(
//       String subscriptionType) async {
//     try {
//       var client = http.Client();

//       var userId = UserDataManager.userData['user_id'];
//       var url = "http://10.0.2.2:8000/api/users/makemeprouser/";

//       var response = await client.post(Uri.parse(url), body: {
//         "user_id": userId,
//         "subscription_type": subscriptionType,
//       });

//       var decodedResponse = jsonDecode(response.body);

//       log(decodedResponse.toString());

//       var status = decodedResponse['status'];
//       var message = decodedResponse['message'];

//       return decodedResponse;
//     } catch (Exception) {}
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:mygymbuddy/functions/shared_preference_functions.dart';

class MakeMeProMemberRepository {
  static Future<Map<String, dynamic>> makeMeProMember(
      String subscriptionType) async {
    try {
      var client = http.Client();
      var userId = UserDataManager.userData['user_id'].toString();
      var url = "http://10.0.2.2:8000/api/users/makemeprouser/";

      var response = await client.post(Uri.parse(url), body: {
        "user_id": userId,
        "subscription_type": subscriptionType,
      });

      var decodedResponse = jsonDecode(response.body);

      var statusCode = decodedResponse['status'];

      if (statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        log(decodedResponse.toString());
        return decodedResponse;
      } else {
        log('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return {
          'status': response.statusCode,
          'message': 'Error: ${response.reasonPhrase}',
        };
      }
    } catch (exception) {
      log('Exception occurred: $exception');
      return {
        'status': '500',
        'message': 'Exception occurred: $exception',
      };
    }
  }
}
