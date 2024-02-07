import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
//will notify change in states

  ThemeData _selectedTheme = ThemeData();

  ThemeData lightTheme = ThemeData.light(useMaterial3: true
      // useMaterial3: true,
      );

  ThemeData darkTheme = ThemeData.dark();

  ThemeProvider({required isDarkMode}) {
    if (isDarkMode) {
      _selectedTheme = darkTheme;
    } else {
      _selectedTheme = lightTheme;
    }
  }

// a getter for selected Theme
  ThemeData get getTheme => _selectedTheme;

  void swapTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;
      preferences.setBool("isDarkTheme", false);
    } else {
      _selectedTheme = darkTheme;
      preferences.setBool("isDarkTheme", true);
    }

    //alert consumers about changes so they can rebuild based on changes
    notifyListeners();
  }
}
