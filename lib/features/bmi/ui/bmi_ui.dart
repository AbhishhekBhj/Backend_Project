import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../provider/themes/theme_provider.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        keyboardAppearance:
                            isDarkMode ? Brightness.dark : Brightness.light,
                        controller: _heightController,
                        decoration: const InputDecoration(
                          hintText: "Enter your height in meters",
                          labelText: "Height",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        keyboardAppearance:
                            isDarkMode ? Brightness.dark : Brightness.light,
                        controller: _weightController,
                        decoration: const InputDecoration(
                          hintText: "Enter your weight in kg",
                          labelText: "Weight",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          double bmi = calculateBMI(
                              double.parse(_heightController.text),
                              double.parse(_weightController.text));

                          String bmiCategory = bmiCateogory(bmi);
                          if (_formKey.currentState!.validate()) {
                            Fluttertoast.showToast(
                              msg: "Your bmi is $bmi and you are $bmiCategory ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                            );

                            FocusScope.of(context).previousFocus();
                          }
                        },
                        child: const Text("Calculate BMI"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? Colors.white30
                              : Colors.deepPurpleAccent,
                          foregroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double calculateBMI(double height, double weight) {
    return weight / (height * height);
  }

  String bmiCateogory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 25) {
      return "Normal";
    } else if (bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }
}
