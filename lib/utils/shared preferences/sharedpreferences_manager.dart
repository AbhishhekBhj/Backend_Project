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

  Future<String?> getFullName() async {
    var prefs = await SharedPreferences.getInstance();
    String? fullname = prefs.getString('fullname');
    print(fullname);
    return fullname;
  }

  Future<void> saveAge(String age) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('age', age);
  }

  Future<String?> getAge() async {
    var prefs = await SharedPreferences.getInstance();
    String? age = prefs.getString('age');
    print(age);
    return age;
  }

  static Future<bool?> getDarkTheme() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isDarkTheme = prefs.getBool('isDarkTheme');
    print(isDarkTheme);
    return isDarkTheme;
  }

  Future<double> getCaloriesConsumedValue() async {
    var prefs = await SharedPreferences.getInstance();
    double? calories = prefs.getDouble("caloriesConsumed");
    return calories!;
  }

  Future<void> setCaloriesConsumedValue(double value) async {
    double currentValue = await getCaloriesConsumedValue();
    var prefs = await SharedPreferences.getInstance();

    prefs.setDouble("caloriesConsumed", currentValue + value);
  }

  
}
