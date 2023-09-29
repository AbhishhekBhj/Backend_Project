import 'package:flutter/material.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 100),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Reminder Title",
                  border: OutlineInputBorder(),
                  labelText: "Reminder Title"),
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Reminder SubTitle",
                  border: OutlineInputBorder(),labelText: "Reminder SubTitle"),
            )
          ],
        ),
      ),
    );
  }
}
