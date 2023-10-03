import 'package:flutter/material.dart';

class ShowTimerPicker extends StatefulWidget {
  final Function(TimeOfDay)? onTimeSelected; // Callback to pass selected time

  ShowTimerPicker({Key? key, this.onTimeSelected}) : super(key: key);

  @override
  _ShowTimerPickerState createState() => _ShowTimerPickerState();
}

class _ShowTimerPickerState extends State<ShowTimerPicker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked;

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) {
      setState(() {
        _time = picked!;
        print(picked);
        // Call the callback to pass the selected time to the parent widget
        widget.onTimeSelected?.call(picked!);
      });
      Navigator.of(context).pop(); // Close the ShowTimerPicker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                selectTime(context);
              },
              child: Text('Select Time'),
            ),
            SizedBox(
              height: 60,
            ),
            Text('$_time', style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
