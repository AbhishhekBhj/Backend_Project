import 'package:flutter/material.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/features/signup/ui/signup.dart';

void main() {
  runApp(const MyApp());
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
