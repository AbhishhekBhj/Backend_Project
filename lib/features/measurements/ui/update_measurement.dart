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

import '../../../functions/shared_preference_functions.dart';
import '../../../provider/themes/theme_provider.dart';

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
                // if (state is MeasurementsInitial) {}
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
                            isProMember
                                ? showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Center(
                                          child: Text("Yo are a Pro Member"),
                                        ),
                                      );
                                    },
                                  )
                                : showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Center(
                                          child:
                                              Text("You are not a Pro Member"),
                                        ),
                                      );
                                    },
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  : LockWidget()
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
                                  decoration: InputDecoration(
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
            return NoInternet();
          }
        },
      ),
    );
  }
}

class LockWidget extends StatelessWidget {
  const LockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void _notProMemberDialogBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: Get.height * 0.2,
            child: Column(
              children: [
                const Text("You are not a Pro Member"),
                const Text("Upgrade to Pro Member to unlock this feature"),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Upgrade"),
                ),
              ],
            ),
          );
        },
      );
    }

    return IconButton(
        onPressed: () {
          _notProMemberDialogBottomSheet(context);
        },
        icon: Icon(FontAwesomeIcons.lock));
  }
}
