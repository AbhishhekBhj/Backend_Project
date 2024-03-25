import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/exercise_library/ui/exercise_library.dart';
import 'package:mygymbuddy/features/home/ui/edit_profile.dart';
import 'package:mygymbuddy/features/profile/ui/view_profile.dart';
import 'package:mygymbuddy/features/reminder/ui/reminders.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_screen.dart/logins.dart';
import 'package:mygymbuddy/features/workout/ui/view_workout_data.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../functions/shared_preference_functions.dart';
import '../../measurements/ui/update_measurement.dart';
import '../../profile/bloc/bloc/profile_bloc.dart';
import '../../profile/ui/change_password.dart';
import '../../progress/ui/progress.dart';
import 'one_rep_max.dart';

class OtherFeaturePage extends StatefulWidget {
  const OtherFeaturePage({Key? key});

  @override
  State<OtherFeaturePage> createState() => _OtherFeaturePageState();
}

class _OtherFeaturePageState extends State<OtherFeaturePage> {
  List<dynamic> exerciseGallery = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    List<dynamic> exercises = await ExerciseBox.getExerciseList();

    setState(() {
      // Update the state with the loaded exercises
      exerciseGallery = exercises;
      log(exerciseGallery.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Function to create decorated ListTiles with onTap
    Widget buildListTile(
      IconData icon,
      VoidCallback? onTap,
      String title,
    ) {
      return GestureDetector(
        onTap: onTap,
        child: Ink(
          child: InkWell(
            splashColor: const Color.fromARGB(255, 125, 125, 241),
            onTap: onTap,
            child: ListTile(
              title: Text(title),
              leading: Icon(icon),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  const Header(),
                  const Divider(thickness: 2),
                  Text(
                    "Other Features",
                    style: textstyle(),
                  ),
                  buildListTile(FontAwesomeIcons.noteSticky, () {
                    Get.to(Reminders());
                  }, "Set Reminders"),
                  buildListTile(Icons.calculate_outlined, () {
                    Get.to(const OneRepMaxCalculationScreen());
                  }, "Calculate One Rep Max"),
                  buildListTile(Icons.view_agenda, () {
                    Get.to(const ViewWorkoutDetails());
                  }, "View Workouts"),
                  buildListTile(FontAwesomeIcons.book, () {
                    Get.to(ExerciseLibrary(
                      exercise: exerciseGallery,
                    ));
                  }, "Exercise Gallery"),
                  buildListTile(FontAwesomeIcons.chartColumn, () {
                    Get.to(const ViewProgressOptions());
                  }, "Progress"),
                  buildListTile(Icons.update, () {
                    Get.to(const UpdateMeasurementsScreen());
                  }, "Update Your Measurements"),
                  buildListTile(FontAwesomeIcons.calculator, () {
                    Get.to(const BMI());
                  }, "Calculate BMI"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Account",
                    style: textstyle(),
                  ),
                  buildListTile(FontAwesomeIcons.bookOpen, () {
                    Get.to(BlocProvider(
                      create: (context) => ProfileBloc(),
                      child: const ChangePasswordScreen(),
                    ));
                  }, "Change Password"),
                  buildListTile(Icons.person_2, () {
                    Get.to(const EditProfileScreen());
                  }, "Edit Profile"),
                  DarkModeSwitchTile(),
                  buildListTile(Icons.logout_rounded, () {
                    Get.off(const DemoLoginPage());
                  }, "Log out"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Column(
              children: [
                const Text("Are you sure you want to log out?"),
                ElevatedButton(
                    onPressed: () {
                      Get.offAll(const DemoLoginPage());
                    },
                    child: const Text("Log out"))
              ],
            ),
          );
        });
  }

  TextStyle textstyle() => const TextStyle(
      fontFamily: "Roboto", fontSize: 24, fontWeight: FontWeight.bold);
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ClipOval(
              child: Container(
                  width: Get.height * 0.12,
                  height: Get.height * 0.12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: UserDataManager.userData["profile_picture"] != ""
                      ? Image.network(
                          'http://10.0.2.2:8000/media/${UserDataManager.userData['profile_picture']!}',
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                          child: const Icon(Icons.person,
                              size: 50, color: Colors.white),
                        )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                UserDataManager.userData["username"],
                style: const TextStyle(fontSize: 20),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(ViewProfile());
                  },
                  child: const Text("View Profile"))
            ],
          ),
        ],
      ),
    );
  }
}

class DarkModeSwitchTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.moon),
      title: const Text('Dark Mode'),
      trailing: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

          return Switch(
            activeColor: Colors.black,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
            inactiveThumbColor: Colors.black,
            value: isDarkMode,
            onChanged: (newValue) {
              themeProvider.swapTheme();
            },
          );
        },
      ),
    );
  }
}
