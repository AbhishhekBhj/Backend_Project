import 'package:flutter/material.dart';
import 'package:mygymbuddy/features/reminder/bloc/reminder_bloc.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class Reminders extends StatefulWidget {
  Reminders({Key? key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  TimeOfDay? selectedTime;
  ReminderBloc reminderBloc = ReminderBloc();

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
    // Handle the selected time here. You can use `selectedTime` for this.
    if (selectedTime != null) {
      print("Selected Time: ${selectedTime!.format(context)}");
      // Perform any other actions you need with the selected time.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 130),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Reminder Title",
                border: OutlineInputBorder(),
                labelText: "Reminder Title",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Reminder SubTitle",
                border: OutlineInputBorder(),
                labelText: "Reminder SubTitle",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Select Time"),
            ),
            SizedBox(height: 20),
            if (selectedTime != null)
              Text(
                "Selected Time: ${selectedTime!.format(context)}",
                style: TextStyle(fontSize: 16),
              ),
            //ToDO:  send reminder notification to the user
          ],
        ),
      ),
    );
  }
}
