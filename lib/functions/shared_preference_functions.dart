import "dart:developer";

import "package:shared_preferences/shared_preferences.dart";

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
    };
  }
}

class UserDataManager {
  static Map<String, dynamic> _userData = {};

  static Map<String, dynamic> get userData => _userData;

  static void set userData(Map<String, dynamic> userData) {
    _userData = userData;
  }

  static Future<void> init() async {
    _userData = await SharedPreferenceHelper.getUserData();
  }
}
