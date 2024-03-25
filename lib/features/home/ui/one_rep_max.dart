import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneRepMaxCalculationScreen extends StatefulWidget {
  const OneRepMaxCalculationScreen({Key? key}) : super(key: key);

  @override
  State<OneRepMaxCalculationScreen> createState() =>
      _OneRepMaxCalculationScreenState();
}

class _OneRepMaxCalculationScreenState
    extends State<OneRepMaxCalculationScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  double oneRepMaxValue = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("One Rep Max Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Enter the weight and reps to calculate your one rep max",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Weight",
                hintText: "Enter the weight in kgs",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reps",
                hintText: "Enter the reps",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _calculateOneRepMax();
              },
              child: Text(isLoading ? 'Calculating...' : 'Calculate'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CupertinoActivityIndicator()
                : Text(
                    "Your one rep max is: ${oneRepMaxValue.toStringAsFixed(2)} kgs",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _calculateOneRepMax() {
    final weight = int.tryParse(weightController.text) ?? 0;
    final reps = int.tryParse(repsController.text) ?? 0;
    final oneRepMax = calculateOneRepMax(weight, reps);

    setState(() {
      oneRepMaxValue = oneRepMax;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  double calculateOneRepMax(int weight, int reps) {
    return weight * (1 + reps / 30);
  }
}
