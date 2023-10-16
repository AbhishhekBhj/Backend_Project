import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  Future<void> saveUsername(String username) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    var prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');

    return name;
  }

  Future<void> saveFullName(String fullName) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('fullname', fullName);
  }

  Future<String?> getFullName(String fullName) async {
    var prefs = await SharedPreferences.getInstance();
    String? fullname = prefs.getString('fullname');
    print(fullName);
    return fullname;
  }

  Future<void> saveAge(String age) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('age', age);
  }

  Future<String?> getAge(String age) async {
    var prefs = await SharedPreferences.getInstance();
    String? age = prefs.getString('age');
    print(age);
    return age;
  }
}
