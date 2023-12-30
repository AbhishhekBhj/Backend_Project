import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class EnterBodyWeight extends StatefulWidget {
  EnterBodyWeight(
      {Key? key,
      required this.bodyWeight,
      required this.isValidBodyWeight,
      required this.onChanged})
      : super(key: key);

  TextEditingController bodyWeight;
  final VoidCallback onChanged;
  bool isValidBodyWeight;

  @override
  State<EnterBodyWeight> createState() => _EnterBodyWeightState();
}

class _EnterBodyWeightState extends State<EnterBodyWeight> {
  @override
  Widget build(BuildContext context) {
final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            const Text(
              'Enter Body Weight',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: Get.width * 0.8,
              child: TextFormField(
                controller: widget.bodyWeight,
                onChanged: (value) {
                  widget.onChanged;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: widget.isValidBodyWeight
                      ? null
                      : "Please enter valid body weigth",
                  hintText: 'Enter Body Weight',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
