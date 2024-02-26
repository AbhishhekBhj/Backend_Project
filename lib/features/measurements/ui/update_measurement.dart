import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/internet/bloc/bloc/internet_bloc.dart';
import 'package:mygymbuddy/features/internet/ui/no_internet.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/models/measurement_model.dart';
import '../../../functions/shared_preference_functions.dart';
import '../../../provider/themes/theme_provider.dart';
import '../../../widgets/not_pro_member_widget.dart';

class UpdateMeasurementsScreen extends StatefulWidget {
  const UpdateMeasurementsScreen({super.key});

  @override
  State<UpdateMeasurementsScreen> createState() =>
      _UpdateMeasurementsScreenState();
}

class _UpdateMeasurementsScreenState extends State<UpdateMeasurementsScreen> {
  late bool isProMember;
  late MeasurementsBloc measurementsBloc;
  late InternetBloc internetBloc;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() {
    measurementsBloc = BlocProvider.of<MeasurementsBloc>(context);
    internetBloc = BlocProvider.of<InternetBloc>(context);
    checkIfProMember();
  }

  void checkIfProMember() async {
    isProMember = getIsProMember();
  }

  bool getIsProMember() {
    bool isProMember = UserDataManager.userData['is_pro_member'];
    log(isProMember.toString() + " isProMember");
    return isProMember;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is InternetRestoredState) {
            return BlocBuilder<MeasurementsBloc, MeasurementsState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    leadingWidth: Get.width * 0.2,
                    leading: TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    actions: [
                      TextButton(
                          child: const Text("Save"),
                          onPressed: () {
                            measurementsBloc.add(
                              MeasurementsUpdateClickedEvent(
                                bodyMeasurement: BodyMeasurement(
                                  height:
                                      double.tryParse(heightController.text) ??
                                          0,
                                  leftArm:
                                      double.tryParse(leftArmController.text) ??
                                          0,
                                  rightArm: double.tryParse(
                                          rightArmController.text) ??
                                      0,
                                  leftForearm: double.tryParse(
                                          leftForearmController.text) ??
                                      0,
                                  rightForearm: double.tryParse(
                                          rightForearmController.text) ??
                                      0,
                                  chestSize:
                                      double.tryParse(chestController.text) ??
                                          0,
                                  waistSize:
                                      double.tryParse(waistController.text) ??
                                          0,
                                  leftQuadricep: double.tryParse(
                                          leftQuadricepController.text) ??
                                      0,
                                  rightQuadricep: double.tryParse(
                                          rightQuadricepController.text) ??
                                      0,
                                  leftCalf: double.tryParse(
                                          leftCalveController.text) ??
                                      0,
                                  rightCalf: double.tryParse(
                                          rightCalveController.text) ??
                                      0,
                                  hipSize:
                                      double.tryParse(hipSizeController.text) ??
                                          0,
                                  notes: notesController.text,
                                  user:
                                      UserDataManager.userData['user_id'] ?? 1,
                                  weight: double.tryParse(
                                          bodyweightController.text) ??
                                      0,
                                ),
                              ),
                            );
                          })
                    ],
                    title: const Text('Update Measurements'),
                  ),
                  body: ListView(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    addAutomaticKeepAlives: true,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Date"),
                            Text("Today   ${DateTime.now().toString()}"),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text("Measurement Options"),
                      const Divider(
                        color: Colors.black,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text("Height"),
                              const Spacer(),
                              SizedBox(
                                width: Get.width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: heightController,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Bodyweight"),
                              const Spacer(),
                              SizedBox(
                                width: Get.width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: bodyweightController,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Left Arm"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: leftArmController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Right Arm"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: rightArmController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Left Forearm"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: leftForearmController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Right Forearm"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: rightForearmController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Chest"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: chestController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Waist"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: waistController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Left Quadricep"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: leftQuadricepController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Right Quadricep"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: rightQuadricepController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Left Calve"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: leftCalveController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Right Calve"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: rightCalveController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text("Hip Size"),
                              const Spacer(),
                              isProMember
                                  ? SizedBox(
                                      width: Get.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: hipSizeController,
                                      ),
                                    )
                                  : const NotProMemberWidget()
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text('Notes'),
                              const Spacer(),
                              SizedBox(
                                height: Get.height * 0.25,
                                width: Get.width * 0.5,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  controller: notesController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const NoInternet();
          }
        },
      ),
    );
  }
}
