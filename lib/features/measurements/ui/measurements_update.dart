// ... (your imports and other code)

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../data/models/measurement_model.dart';
import '../../../provider/themes/theme_provider.dart';
import '../bloc/bloc/measurements_bloc.dart';

class UpdateMeasurements extends StatefulWidget {
  const UpdateMeasurements({Key? key}) : super(key: key);

  @override
  _UpdateMeasurementsState createState() => _UpdateMeasurementsState();
}

class _UpdateMeasurementsState extends State<UpdateMeasurements> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController leftArmController = TextEditingController();
  final TextEditingController rightArmController = TextEditingController();
  final TextEditingController chestController = TextEditingController();
  final TextEditingController leftQuadricepController = TextEditingController();
  final TextEditingController rightQuadricepController =
      TextEditingController();
  final TextEditingController leftCalveController = TextEditingController();
  final TextEditingController rightCalveController = TextEditingController();
  final TextEditingController leftForearmController = TextEditingController();
  final TextEditingController rightForearmController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController bodyweightController = TextEditingController();
  final TextEditingController hipSizeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final MeasurementsBloc measurementBloc = MeasurementsBloc();

  @override
  void dispose() {
    leftArmController.dispose();
    rightArmController.dispose();
    chestController.dispose();
    leftQuadricepController.dispose();
    rightQuadricepController.dispose();
    leftCalveController.dispose();
    rightCalveController.dispose();
    leftForearmController.dispose();
    rightForearmController.dispose();
    waistController.dispose();
    bodyweightController.dispose();
    hipSizeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Platform.isAndroid
                ? const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
          ),
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          title: Text(
            'Update Measurements',
            style: TextStyle(
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.085,
                horizontal: screenWidth * 0.07,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    decoration: const InputDecoration(
                      hintText: 'Height (cm)',
                      labelText: 'Height',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: bodyweightController,
                    decoration: const InputDecoration(
                      hintText: 'Body Weight (kg)',
                      labelText: 'Body Weight',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Left Arm (inches)',
                      hintText: 'Left Arm',
                    ),
                    controller: leftArmController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Right Arm (inches)',
                      hintText: 'Right Arm',
                    ),
                    controller: rightArmController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Left Forearm (inches)',
                      hintText: 'Left Forearm',
                    ),
                    controller: leftForearmController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Right Forearm (inches)',
                      hintText: 'Right Forearm',
                    ),
                    controller: rightForearmController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Chest (inches)',
                      hintText: 'Chest',
                    ),
                    controller: chestController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Waist (inches)',
                      hintText: 'Waist',
                    ),
                    controller: waistController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Left Quadricep (inches)',
                      hintText: 'Left Quadricep',
                    ),
                    controller: leftQuadricepController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Right Quadricep (inches)',
                      hintText: 'Right Quadricep',
                    ),
                    controller: rightQuadricepController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Left Calve (inches)',
                      hintText: 'Left Calve',
                    ),
                    controller: leftCalveController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Right Calve (inches)',
                      hintText: 'Right Calve',
                    ),
                    controller: rightCalveController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hip Size (inches)',
                      hintText: 'Hip Size',
                    ),
                    controller: hipSizeController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Additional Notes',
                    ),
                    controller: notesController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (validateFields()) {
                        measurementBloc.add(
                          MeasurementsUpdateClickedEvent(
                            bodyMeasurement: BodyMeasurement(
                              height:
                                  double.tryParse(heightController.text) ?? 0.0,
                              weight:
                                  double.tryParse(bodyweightController.text) ??
                                      0.0,
                              chestSize:
                                  double.tryParse(chestController.text) ?? 0.0,
                              waistSize:
                                  double.tryParse(waistController.text) ?? 0.0,
                              hipSize:
                                  double.tryParse(hipSizeController.text) ??
                                      0.0,
                              leftArm:
                                  double.tryParse(leftArmController.text) ??
                                      0.0,
                              rightArm:
                                  double.tryParse(rightArmController.text) ??
                                      0.0,
                              leftQuadricep: double.tryParse(
                                      leftQuadricepController.text) ??
                                  0.0,
                              rightQuadricep: double.tryParse(
                                      rightQuadricepController.text) ??
                                  0.0,
                              leftCalf:
                                  double.tryParse(leftCalveController.text) ??
                                      0.0,
                              rightCalf:
                                  double.tryParse(rightCalveController.text) ??
                                      0.0,
                              leftForearm:
                                  double.tryParse(leftForearmController.text) ??
                                      0.0,
                              rightForearm: double.tryParse(
                                      rightForearmController.text) ??
                                  0.0,
                              notes: notesController.text,
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          backgroundColor: Colors.deepPurpleAccent,
                          msg: 'Please fill all the fields',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    ),
                    child: Text(
                      'Update Measurements',
                      style: TextStyle(
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder(
              bloc: measurementBloc,
              builder: (context, state) {
                if (state is MeasurementUpdateLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void clearAllTextFields() {
    setState(() {
      bodyweightController.clear();
      leftArmController.clear();
      rightArmController.clear();
      leftForearmController.clear();
      rightForearmController.clear();
      chestController.clear();
      waistController.clear();
      leftQuadricepController.clear();
      rightQuadricepController.clear();
      leftCalveController.clear();
      rightCalveController.clear();
      hipSizeController.clear();
      notesController.clear();
    });
  }

  bool validateFields() {
    return _isDouble(bodyweightController.text) &&
        _isDouble(leftArmController.text) &&
        _isDouble(rightArmController.text) &&
        _isDouble(leftForearmController.text) &&
        _isDouble(rightForearmController.text) &&
        _isDouble(chestController.text) &&
        _isDouble(waistController.text) &&
        _isDouble(leftQuadricepController.text) &&
        _isDouble(rightQuadricepController.text) &&
        _isDouble(leftCalveController.text) &&
        _isDouble(rightCalveController.text);
  }

  bool _isDouble(String value) {
    try {
      double.parse(value);
      log('Value is double');
      return true;
    } catch (e) {
      return false;
    }
  }
}
