import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/exercise_library/ui/exercise_library.dart';
import 'package:mygymbuddy/features/home/ui/edit_profile.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_update.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_view_history.dart';
import 'package:mygymbuddy/features/profile/ui/view_profile.dart';
import 'package:mygymbuddy/features/reminder/ui/reminders.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_screen.dart/logins.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:provider/provider.dart';

import '../../../functions/shared_preference_functions.dart';
import '../../profile/bloc/bloc/profile_bloc.dart';
import '../../profile/ui/change_password.dart';

class OtherFeaturePage extends StatelessWidget {
  const OtherFeaturePage({Key? key});

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
            splashColor: Color.fromARGB(255, 125, 125, 241),
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
                  Header(),
                  Divider(thickness: 2),
                  Text(
                    "Other Features",
                    style: textstyle(),
                  ),
                  buildListTile(FontAwesomeIcons.noteSticky, () {
                    Get.to(Reminders());
                  }, "Set Reminders"),
                  buildListTile(FontAwesomeIcons.book, () {
                    Get.to(ExerciseLibrary());
                  }, "Exercise Gallery"),
                  buildListTile(FontAwesomeIcons.chartColumn, () {
                    Get.to(ViewMeasurementsHistory());
                  }, "Progress"),
                  buildListTile(Icons.update, () {
                    Get.to(UpdateMeasurements());
                  }, "Update Your Measurements"),
                  buildListTile(FontAwesomeIcons.calculator, () {
                    Get.to(BMI());
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
                      child: ChangePasswordScreen(),
                    ));
                  }, "Change Password"),

                  buildListTile(Icons.person_2, () {
                    Get.to(EditProfileScreen());
                  }, "Edit Profile"),

                  DarkModeSwitchTile(),

                  // buildListTile(FontAwesomeIcons.moon, () {
                  //   //use provider to detect change and change theme
                  //   ThemeProvider
                  //       themeProvider = //listen is set to false to avoid this part rebuilding itself
                  //       Provider.of<ThemeProvider>(context, listen: false);
                  //   themeProvider.swapTheme();
                  // }, "Change Theme"),
                  buildListTile(Icons.logout_rounded, () {
                    Get.off(DemoLoginPage());
                  }, "Log out"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textstyle() => TextStyle(
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: UserDataManager.userData["profile_picture"] != ""
                      ? Image.network(
                          'http://10.0.2.2:8000/media/${UserDataManager.userData['profile_picture']!}',
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                          child:
                              Icon(Icons.person, size: 50, color: Colors.white),
                        )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                UserDataManager.userData["username"],
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(ViewProfile());
                  },
                  child: Text("View Profile"))
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
      leading: Icon(FontAwesomeIcons.moon),
      title: Text('Dark Mode'),
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
