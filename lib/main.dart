import 'package:flutter/material.dart';
import 'package:mygymbuddy/features/signup/ui/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/reminder/ui/reminders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var username = sharedPreferences.getString('username');

  runApp(MaterialApp(home: username == null ? Signup() : Reminders()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Signup(),
      debugShowCheckedModeBanner: false,
    );
  }
}
