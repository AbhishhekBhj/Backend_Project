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
import 'package:mygymbuddy/utils/texts/texts.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  _buildDecoratedListTile(FontAwesomeIcons.noteSticky, () {
                    Get.to(Reminders());
                  }, "Set Reminders"),
                  _buildDecoratedListTile(FontAwesomeIcons.book, () {
                    Get.to(ExerciseLibrary());
                  }, "Exercise Gallery"),
                  _buildDecoratedListTile(FontAwesomeIcons.chartColumn, () {
                    Get.to(ViewMeasurementsHistory());
                  }, "Progress"),
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
                    style: textstyle(),
                  ),
                  _buildDecoratedListTile(
                      FontAwesomeIcons.bookOpen, () {}, "Change Password"),
                  _buildDecoratedListTile(
                      FontAwesomeIcons.moon, () {}, "Change Theme"),
                  _buildDecoratedListTile(Icons.logout_rounded, () {
                    Get.offAll(() => Login());
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: Get.height * 0.1,
          height: Get.height * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(splashImage),
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "USERNAME",
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
    );
  }
}
