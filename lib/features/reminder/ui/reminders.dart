import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/services/notification_services.dart';
import 'package:mygymbuddy/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reminders extends StatefulWidget {
  Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  DateTime? _selectedDateTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String username;

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
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
                          _selectDate(context);
                        },
                        icon: const Icon(Icons.alarm),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "Reminder Description",
                    ),
                  ),
                  Text(
                    _selectedDateTime == null
                        ? "No date and time selected"
                        : "Selected date and time: ${_selectedDateTime!.toLocal()}",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        await showNotificationAndSchedule();
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

  Future<void> showNotificationAndSchedule() async {
    String reminder = titleController.text;
    String description = descriptionController.text;

    if (_selectedDateTime != null &&
        _selectedDateTime!.isAfter(DateTime.now())) {
      await NotificationService()
          .scheduleNotification(reminder, description, _selectedDateTime!);
    } else {
      Fluttertoast.showToast(
          msg: "Please select a future date and time for the reminder");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
