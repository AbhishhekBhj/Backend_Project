import 'package:flutter/material.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmi = 0.0;
  String bmiCategory = '';

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      setState(() {
        bmi = weight / (height * height);

        if (bmi < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 25) {
          bmiCategory = 'Normal';
        } else if (bmi >= 25 && bmi < 30) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CommonAppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: enterWeight),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: enterHeight),
              ),
              ElevatedButton(
                onPressed: () {
                  calculateBMI();
                },
                child: Text(calculateBmi),
              ),
              ElevatedButton(
                  onPressed: () {
                    clearTextField();
                  },
                  child: Text(clearTextFields)),
              SizedBox(height: screenHeight * 0.01),
              Text('BMI: ${bmi.toStringAsFixed(2)}'),
              Text('Category: $bmiCategory'),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextField() {
    setState(() {
      heightController.clear();
      weightController.clear();
      bmi = 0.0;
      bmiCategory = "";
    });
  }
}
