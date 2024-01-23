import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/reminder_model.dart';
import 'package:mygymbuddy/features/reminder/bloc/reminder_bloc.dart';
import 'package:mygymbuddy/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:developer";

class Reminders extends StatefulWidget {
  Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  TimeOfDay? selectedTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String username;

  ReminderBloc reminderBloc = ReminderBloc();
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadUserName();
  }

  Future<void> loadUserName() async {
    setState(() {
      username = sharedPreferences.getString("username") ?? 'test';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            const HeaderWidget(text: "Set Reminder"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.125),
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 2,
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Reminder Title",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDateTime(context);
                        },
                        icon: Icon(Icons.alarm),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "Reminder Description",
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedTime != null)
                    Text(
                      "Selected Date and Time: ${_formatDateTime(selectedTime!)}, $selectedTime",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        _setReminder();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields");
                      }
                    },
                    child: const Text(
                      "Set Reminder",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedTime =
              TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
        });
      }
    }
  }

  String _formatDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return selectedDateTime.toString(); // Adjust the format as needed
  }

  void _setReminder() {
    log(username);
    log(_formatDateTime(selectedTime!));
    log(titleController.text);
    log(descriptionController.text);
    if (selectedTime != null) {
      reminderBloc.add(SetReminderClickedEvent(
          reminders: Reminder(
              username: username,
              title: titleController.text,
              description: descriptionController.text,
              dueDate: _formatDateTime(selectedTime!))));
    }
  }
}
