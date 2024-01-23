import 'package:hive/hive.dart';

class UserAuthenticationLocalStorage {
//opening hive box

  static final Box<dynamic> userAuthenticationStore =
      Hive.box('userAuthenticationStore');

  static Future<void> saveUserName(String userName) async {
    await userAuthenticationStore.put('userName', userName);
  }

  static Future<void> saveUserEmail(String userEmail) async {
    await userAuthenticationStore.put('userEmail', userEmail);
  }

  static Future<void> saveUserPassword(String userPassword) async {
    await userAuthenticationStore.put('userPassword', userPassword);
  }

  static Future<void> saveUserAge(String userAge) async {
    await userAuthenticationStore.put('userAge', userAge);
  }

  static Future<void> saveUserImage(String userImage) async {
    await userAuthenticationStore.put('userImage', userImage);
  }

  static Future<void> saveName(String name) async {
    await userAuthenticationStore.put('name', name);
  }

  static Future<void> saveIsProMember(bool isProMember) async {
    await userAuthenticationStore.put('isProMember', isProMember);
  }

  static Future<void> saveGender(String gender) async {
    await userAuthenticationStore.put('gender', gender);
  }

  static Future saveFitnessGoal(String fitnessGoal) async {
    await userAuthenticationStore.put('fitnessGoal', fitnessGoal);
  }

  static Future saveHeight(String height) async {
    await userAuthenticationStore.put('height', height);
  }

  //now getting data from hive box

  static String getUserName() {
    return userAuthenticationStore.get('userName') as String;
  }

  static String getUserEmail() {
    return userAuthenticationStore.get('userEmail') as String;
  }

  static String getUserPassword() {
    return userAuthenticationStore.get('userPassword') as String;
  }

  static String getUserAge() {
    return userAuthenticationStore.get('userAge') as String;
  }

  static String getUserImage() {
    return userAuthenticationStore.get('userImage') as String;
  }

  static String getName() {
    return userAuthenticationStore.get('name') as String;
  }

  static bool getIsProMember() {
    return userAuthenticationStore.get('isProMember') as bool;
  }
}
