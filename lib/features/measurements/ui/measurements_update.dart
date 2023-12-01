import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/data/models/measurement_model.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class UpdateMeasurements extends StatefulWidget {
  const UpdateMeasurements({super.key});

  @override
  State<UpdateMeasurements> createState() => _UpdateMeasurementsState();
}

class _UpdateMeasurementsState extends State<UpdateMeasurements> {
  // Create TextEditingController instances for each attribute
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
  final MeasurementsBloc measurementBloc = MeasurementsBloc();
  @override
  void initState() {
    measurementBloc.add(MeasurementsInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<MeasurementsBloc, MeasurementsState>(
      bloc: measurementBloc,
      listenWhen: (previous, current) => current is MeasurementsActionState,
      buildWhen: (previous, current) => current is! MeasurementsActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case MeasurementsInitial:
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                  body: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.085,
                          horizontal: screenWidth * 0.07),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeaderWidget(text: "UPDATE MEASUREMENTS"),
                          TextFormField(
                              controller: bodyweightController,
                              decoration: const InputDecoration(
                                  hintText: bodyWeightHintText,
                                  labelText: bodyWeightLabel)),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: leftArmLabel,
                              hintText: leftArmHintText,
                            ),
                            controller: leftArmController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: rightArmLabel,
                              hintText: rightArmHintText,
                            ),
                            controller: rightArmController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: leftForeArmLabel,
                              hintText: leftForeArmHintText,
                            ),
                            controller: leftForearmController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: rightForeLabel,
                              hintText: rightForeHintText,
                            ),
                            controller: rightForearmController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: chestLabel,
                              hintText: chestHintText,
                            ),
                            controller: chestController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: waistLabel,
                              hintText: waistHintText,
                            ),
                            controller: waistController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: leftQuadricepLabel,
                              hintText: leftQuadricepHintText,
                            ),
                            controller: leftQuadricepController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: rightQuadricepLabel,
                              hintText: rightQuadricepHintText,
                            ),
                            controller: rightQuadricepController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: leftCalveLabel,
                              hintText: leftCalveHintText,
                            ),
                            controller: leftCalveController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: rightCalveLabel,
                                hintText: rightCalveHintText),
                            controller: rightCalveController,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                measurementBloc
                                    .add(MeasurementsUpdateClickedEvent(
                                  measurementModel: Measurement(
                                    leftArm: double.tryParse(
                                            leftArmController.text) ??
                                        0.0,
                                    rightArm: double.tryParse(
                                            rightArmController.text) ??
                                        0.0,
                                    chest:
                                        double.tryParse(chestController.text) ??
                                            0.0,
                                    leftQuadricep: double.tryParse(
                                            leftQuadricepController.text) ??
                                        0.0,
                                    rightQuadricep: double.tryParse(
                                            rightQuadricepController.text) ??
                                        0.0,
                                    leftCalve: double.tryParse(
                                            leftCalveController.text) ??
                                        0.0,
                                    rightCalve: double.tryParse(
                                            rightCalveController.text) ??
                                        0.0,
                                    leftForearm: double.tryParse(
                                            leftForearmController.text) ??
                                        0.0,
                                    rightForearm: double.tryParse(
                                            rightForearmController.text) ??
                                        0.0,
                                    waist:
                                        double.tryParse(waistController.text) ??
                                            0.0,
                                    bodyweight: double.tryParse(
                                            bodyweightController.text) ??
                                        0.0,
                                  ),
                                ));
                              },
                              child: Text(updateMeasurements)),
                          Text(
                              "Note: The average of your left and right side bodypart will be stored ")
                        ],
                      ))
                ],
              )),
            );

          case MeasurementHistoryViewLoadingState:
            return CircularProgressIndicator(
              color: Colors.black,
            );

          case MeasurementUpdateLoadingState:
            return CircularProgressIndicator(
              color: Colors.black,
            );

          case MeasurementHistoryViewFailureState:
            return Center(
              child: Text(
                  "An Unexpected Error Occured while requesting this page",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            );

          case MeasurmentsUpdateFailureState:
            return Center(
              child: Text(
                  "An Unexpected Error Occured while updating measuremetn",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            );

          case MeasurementUpdateSuccessState:
            //ToDo: show alert box
            return Text("Cool");
        }
        return Scaffold();
      },
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
    });
  }
}
