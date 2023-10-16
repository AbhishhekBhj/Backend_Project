import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/reminder/bloc/reminder_bloc.dart';
import 'package:mygymbuddy/services/notification_services.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class Reminders extends StatefulWidget {
  Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  NotificationServices notificationServices = NotificationServices();
  TimeOfDay? selectedTime;
  ReminderBloc reminderBloc = ReminderBloc();

  List<Map<String, Object>> reminders = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _handleTimeSelection() {
    if (selectedTime != null) {
      print("Selected Time: ${selectedTime!.format(context)}");
    }
  }

  void _setReminder() {
    if (selectedTime != null) {
      setState(() {
        var remindersMap = {
          "Title": titleController.text,
          "SubTitle": subTitleController.text,
          "ReminderTime": selectedTime.toString()
        };
        reminders.add(remindersMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasReminders = reminders.isNotEmpty;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          HeaderWidget(text: "Set Reminder"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.125),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Reminder Title",
                    border: UnderlineInputBorder(),
                    labelText: "Reminder Title",
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: subTitleController,
                  decoration: InputDecoration(
                    hintText: "Enter Reminder SubTitle",
                    border: UnderlineInputBorder(),
                    labelText: "Reminder SubTitle",
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text("Select time to set the reminder"),
                ),
                SizedBox(height: 20),
                if (selectedTime != null)
                  Text(
                    "Selected Time: ${selectedTime!.format(context)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text != "" &&
                        subTitleController.text != "") {
                      log('00');
                      //TODO: this is demo notfication use firebase later to send notification in the time selected by the user
                      notificationServices.sendNotifications(
                          titleController.text, subTitleController.text);
                      setState(() {
                        titleController.text = "";
                        subTitleController.text = "";
                      });
                    }
                  },
                  child: Text(
                    "Set Reminder",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          if (hasReminders)
            Container(
              child: Column(
                children: <Widget>[
                  for (var reminder in reminders)
                    ReminderItem(reminder: reminder),
                ],
              ),
            )
          else
            Container(
              child: Center(
                child: Text("No reminders"),
              ),
            ),
        ],
      ),
    );
  }
}

class ReminderItem extends StatelessWidget {
  final Map<String, Object> reminder;

  ReminderItem({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreenAccent,
      child: ListTile(
        title: Text(
          reminder["Title"].toString(),
          style: reminderTextStyle(),
        ),
        subtitle: Text(
          reminder["SubTitle"].toString(),
          style: reminderTextStyle(),
        ),
        trailing: Text(
          reminder["ReminderTime"].toString(),
          style: reminderTextStyle(),
        ),
      ),
    );
  }

  TextStyle reminderTextStyle() => TextStyle(color: Colors.grey);
}
