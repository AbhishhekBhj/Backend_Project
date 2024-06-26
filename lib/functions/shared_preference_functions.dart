import "dart:convert";
import "dart:developer";

import "package:hive_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../data/models/home_model.dart";
import 'exercise.dart';

// this file will contain all the function to set and get values wherever shared preference is required
Future<void> saveUsername(String? username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username ?? ''); // Save the username
}

Future<void> saveAccessToken(String? accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log(accessToken!);
  await prefs.setString(
      'accessToken', accessToken ?? ''); // Save the access token
}

Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken') ?? '';
}

Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? '';
}

Future<String?> getRefreshToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('refreshToken') ?? '';
}

Future<void> saveRefreshToken(String? refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'refreshToken', refreshToken ?? ''); // Save the refresh token
}

Future<void> saveExerciseList(List<Exercises> exerciseList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log('method invoked, exerciseList: $exerciseList');
  bool value = await prefs.setStringList(
      "exerciseList", exerciseList.map((e) => e.toJson().toString()).toList());
  log(value.toString());
}

Future<void> saveTodaysCaloricIntake(
    double caloricIntake, String message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  double currentCaloricIntake = await getTodaysCaloricIntake();

  if (message == "Caloric Intake Object Created") {
    double newCaloricIntake = currentCaloricIntake + caloricIntake;
    await prefs.setDouble('caloricIntake', newCaloricIntake);
  } else if (message == "Caloric Intake Object Deleted") {
    double newCaloricIntake = currentCaloricIntake - caloricIntake;
    await prefs.setDouble('caloricIntake', newCaloricIntake);
  } else if (message == 'Caloric Intake Object Updated') {}
}

Future<double> getTodaysCaloricIntake() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('caloricIntake') ?? 0;
}

Future<void> saveTodaysWaterIntake(double waterIntake) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  double currentWaterIntake = await getTodaysWaterIntake();

  double newWaterIntake = currentWaterIntake + waterIntake;

  await prefs.setDouble('waterIntake', newWaterIntake);
}

Future<double> getTodaysWaterIntake() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('waterIntake') ?? 0;
}

Future<void> saveCaloricIntakeMap(Map<String, dynamic> caloricIntakeMap) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log((jsonEncode(caloricIntakeMap)));
  await prefs.setString('caloricIntakeMap', jsonEncode(caloricIntakeMap));
}

Future<Map<String, dynamic>> getCaloricIntakeMap() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return jsonDecode(prefs.getString('caloricIntakeMap') ?? '{}');
}

class SharedPreferenceHelper {
  static const String _keyUserId = 'user_id';
  static const String _keyName = 'name';
  static const String _keyUsername = 'username';
  static const String _keyAge = 'age';
  static const String _keyEmail = 'email';
  static const String _keyFitnessLevel = 'fitness_level';
  static const String _keyIsProMember = 'is_pro_member';
  static const String _keyFitnessGoal = 'fitness_goal';
  static const String _keyProfilePicture = 'profile_picture';
  static const String _keyWeight = 'weight';
  static const String _keyHeight = 'height';
  static const String _keyGender = "gender";

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(_keyUserId, userData['user_id']);
    prefs.setString(_keyName, userData['name']);
    prefs.setString(_keyUsername, userData['username']);
    prefs.setInt(_keyAge, userData['age']);
    prefs.setString(_keyEmail, userData['email']);
    prefs.setString(_keyFitnessLevel, userData['fitness_level']);
    prefs.setBool(_keyIsProMember, userData['is_pro_member']);
    prefs.setString(_keyFitnessGoal, userData['fitness_goal']);
    prefs.setString(_keyProfilePicture, userData['profile_picture']);
    prefs.setDouble(_keyWeight, userData['weight']);
    prefs.setDouble(_keyHeight, userData['height']);
    prefs.setString(_keyGender, userData['gender']);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'user_id': prefs.getInt(_keyUserId),
      'name': prefs.getString(_keyName),
      'username': prefs.getString(_keyUsername),
      'age': prefs.getInt(_keyAge),
      'email': prefs.getString(_keyEmail),
      'fitness_level': prefs.getString(_keyFitnessLevel),
      'is_pro_member': prefs.getBool(_keyIsProMember),
      'fitness_goal': prefs.getString(_keyFitnessGoal),
      'profile_picture': prefs.getString(_keyProfilePicture),
      'weight': prefs.getDouble(_keyWeight),
      'height': prefs.getDouble(_keyHeight),
      'gender':prefs.getString(_keyGender)
    };
  }
}

class UserDataManager {
  static Map<String, dynamic> _userData = {};

  static Map<String, dynamic> get userData => _userData;

  static set userData(Map<String, dynamic> userData) {
    _userData = userData;
  }

  static Future<void> init() async {
    _userData = await SharedPreferenceHelper.getUserData();
  }
}

class ExerciseBox {
  static const String _boxName = "exerciseList";

  static Future<void> saveExerciseList(List<dynamic> exerciseList) async {
    // Convert each dynamic object into an Exercise object
    List<Exercise> exercises = exerciseList.map((dynamic item) {
      return Exercise.fromJson(item);
    }).toList();

    // Save the list of Exercise objects
    var box = await Hive.openBox<Exercise>(_boxName);
    await box.clear();
    await box.addAll(exercises);
  }

  static Future<List<Exercise>> getExerciseList() async {
    var box = await Hive.openBox<Exercise>(_boxName);
    List<Exercise> exerciseList = box.values.toList();
    log(exerciseList.toString() + "exerciseList");
    return exerciseList;
  }
}


// class ExerciseBox {
//   static const String _boxName = "exerciseList";

//   static Future<void> saveExercisesList(List<Exercises> exercisesList) async {
//     var box = await Hive.openBox<Exercises>(_boxName);
//     await box.clear();
//     await box.addAll(exercisesList);
//     await box.close();
//   }

// static  Future<List<Exercises>> getExercisesList() async {
//     var box = await Hive.openBox<Exercises>(_boxName);
//     List<Exercises> exercisesList = box.values.toList();
//     await box.close();
//     return exercisesList;
//   }
// }
