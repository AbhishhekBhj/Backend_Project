import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/home_model.dart';
import 'package:mygymbuddy/data/models/token_model.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class HomeRepository {
  Future<TokenModel> getTokens(String username, String password) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${baseUrl}token/obtain/'), body: {
        'username': username,
        'password': password,
      });

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      int status = responseBody['status'];

      if (status == 200) {
        TokenModel tokenModel = TokenModel.fromJson(responseBody);
        await saveAccessToken(tokenModel.token);
        await saveRefreshToken(tokenModel.refreshToken);
        await saveUsername(username);
        return tokenModel;
      } else {
        return TokenModel(
          token: '',
          refreshToken: '',
        );
      }
    } catch (e) {
      log(e.toString());
      throw e;
    } finally {
      client.close();
    }
  }

  Future<String> getNewToken(String refreshToken) async{
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${baseUrl}token/refresh/'), body: {
        'refresh': refreshToken,
      });

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      int status = responseBody['status'];

      if (status == 200) {
        TokenModel tokenModel = TokenModel.fromJson(responseBody);
        await saveAccessToken(tokenModel.token);
        await saveRefreshToken(tokenModel.refreshToken);
        return tokenModel.token!;
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      throw e;
    } finally {
      client.close();
    }
  }

  Future<HomeModel> getHomePageData() async {
    String? accessToken = await getAccessToken();
    String? username = await getUsername();
    var client = http.Client();

    List<Exercises> exerciseData = [];
    Map<String, dynamic> workoutData = {};
    Map<String, dynamic> waterIntakeData = {};
    Map<String, dynamic> reminderData = {};
    Map<String, dynamic> measurementData = {};

    try {
      var response = await client.get(Uri.parse('${baseUrl}home/$username/'),
          headers: {"Authorization": "Bearer $accessToken"});

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      int status = responseBody['status'];

      if (status == 200) {
        HomeModel homeModel = HomeModel.fromJson(responseBody);

        exerciseData = homeModel.exerciseData;
        workoutData = homeModel.workoutData;
        waterIntakeData = homeModel.waterIntakeData;
        reminderData = homeModel.reminderData;
        measurementData = homeModel.measurementData;

        await ExerciseBox.saveExerciseList(
            responseBody['data']['exercise_data']);
        // final exerciseDataList = exerciseData.map((e) => e.toJson()).toList();

        // final exerciseDataBox = await Hive.openBox('exerciseData');
        // await exerciseDataBox.put('exerciseData', exerciseDataList);

        // saveExerciseList(exerciseData);
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
