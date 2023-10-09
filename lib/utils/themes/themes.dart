//TODO:define custom themes to be used in the application

import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.grey[100],
        appBarTheme: AppBarTheme(
            backgroundColor:
                isDarkTheme ? Colors.black : MyColors.accentPurple),
        hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        textTheme: Typography.whiteCupertino);
  }
}
