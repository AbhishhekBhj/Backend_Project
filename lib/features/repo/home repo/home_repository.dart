import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/home_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class HomeRepository {
  Future<HomeModel> getHomePageData() async {
    String? accessToken = await getAccessToken();
    String? username = await getUsername();
    var client = http.Client();

    List<Exercise> exerciseData = [];
    Map<String, dynamic> workoutData = {};
    Map<String, dynamic> waterIntakeData = {};
    Map<String, dynamic> reminderData = {};
    Map<String, dynamic> measurementData = {};

    try {
      var response = await client.get(Uri.parse('${baseUrl}home/$username/'),
          headers: {"Authorization": "Bearer $accessToken"});

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      int status = responseBody['status'];
      log(status.toString());

      if (status == 200) {
        HomeModel homeModel = HomeModel.fromJson(responseBody);

        exerciseData = homeModel.exerciseData;
        workoutData = homeModel.workoutData;
        waterIntakeData = homeModel.waterIntakeData;
        reminderData = homeModel.reminderData;
        measurementData = homeModel.measurementData;
      }
      return HomeModel(
        exerciseData: exerciseData,
        workoutData: workoutData,
        waterIntakeData: waterIntakeData,
        reminderData: reminderData,
        measurementData: measurementData,
      );
    } catch (e) {
      log(e.toString());
      throw e;
    } finally {
      client.close();
    }
  }
}
