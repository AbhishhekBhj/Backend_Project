import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/exercise_library/ui/exercise_library.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_update.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_view_history.dart';
import 'package:mygymbuddy/features/profile/ui/view_profile.dart';
import 'package:mygymbuddy/features/reminder/ui/reminders.dart';

class OtherFeaturePage extends StatelessWidget {
  const OtherFeaturePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Function to create decorated ListTiles with onTap
    Widget _buildDecoratedListTile(
      IconData icon,
      VoidCallback? onTap,
      String title,
    ) {
      return GestureDetector(
        onTap: onTap,
        child: Ink(
          child: InkWell(
            onLongPress: () {},
            splashColor: MyColors.lightPurple,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Other Features",
                    style: titleColor(),
                  ),
                  _buildDecoratedListTile(FontAwesomeIcons.noteSticky, () {
                    Get.to(Reminders());
                  }, "Set Reminders"),
                  _buildDecoratedListTile(FontAwesomeIcons.book, () {
                    Get.to(ExerciseLibrary());
                  }, "Exercise Gallery"),
                  _buildDecoratedListTile(Icons.history_outlined, () {
                    Get.to(ViewMeasurementsHistory());
                  }, "View Measurement History"),
                  _buildDecoratedListTile(Icons.update, () {
                    Get.to(UpdateMeasurements());
                  }, "Update Your Measurements"),
                  _buildDecoratedListTile(FontAwesomeIcons.calculator, () {
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
                    style: titleColor(),
                  ),
                  _buildDecoratedListTile(Icons.person, () {
                    Get.to(() => ViewProfile());
                  }, "Profile"),
                  _buildDecoratedListTile(Icons.logout_rounded, () {
                    Get.offAll(() => Login());
                  }, "Log out"),
                  _buildDecoratedListTile(
                      FontAwesomeIcons.bookOpen, () {}, "Change Password"),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "More",
                          style: titleColor(),
                        ),
                        _buildDecoratedListTile(
                            FontAwesomeIcons.moon, () {}, "Change Theme"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle titleColor() {
    return TextStyle(
        color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20);
  }
}
