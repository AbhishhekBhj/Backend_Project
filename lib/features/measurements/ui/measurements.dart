import 'package:flutter/material.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';

class MeasurementViewOptions extends StatelessWidget {
  const MeasurementViewOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> bodyList = ["ARMS","QUADRICPES","WAIST","CALVES","CHEST"];
    ThemeProvider themeProvider;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
