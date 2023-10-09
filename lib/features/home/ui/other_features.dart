import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/reminder/ui/reminders.dart';

class OtherFeaturePage extends StatelessWidget {
  const OtherFeaturePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Function to create decorated ListTiles with onTap
    Widget _buildDecoratedListTile(
        IconData icon, VoidCallback? onTap, String title) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2), // Adjust margin as needed

          child: ListTile(
            title: Text(title),
            leading: Icon(icon),
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
                    print("object");
                  }, "Exercise Gallery"),
                  _buildDecoratedListTile(Icons.history_outlined, () {
                    print("object");
                  }, "View Measurement History"),
                  _buildDecoratedListTile(Icons.update, () {
                    print("object");
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
                    print("object");
                  }, "Profile"),
                  _buildDecoratedListTile(
                      Icons.logout_rounded, () {}, "Log out"),
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
