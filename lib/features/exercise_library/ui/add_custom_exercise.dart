import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class AddCustomExercise extends StatefulWidget {
  const AddCustomExercise({Key? key}) : super(key: key);

  @override
  State<AddCustomExercise> createState() => _AddCustomExerciseState();
}

class _AddCustomExerciseState extends State<AddCustomExercise> {
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController caloriesBurnedPerHourController =
      TextEditingController();

  List bodyParts = [];

  void addItemToList(String item) {
    setState(() {
      bodyParts.add(item);
    });
  }

  
  void removeItemFromList(int index) {
    setState(() {
      bodyParts.removeAt(index);
    });
  }

  Map<int, String> exerciseData = {
    1: 'Front Delts',
    2: 'Reat Delts',
    3: 'Quadriceps',
    4: 'Hamstrings',
    5: 'Glutes Maximus',
    6: 'Lower Back',
    7: 'Lats',
    8: 'Chest',
    9: 'Forearms',
    10: "Biceps"
  };

  Map<int, String> exerciseType = {
    1: 'Cardiovascular',
    2: 'Yoga',
    3: 'Strength Training',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Exercise'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            const Text('Add Custom Exercise'),
            TextFormField(
              autofocus: true,
              controller: exerciseNameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            TextFormField(
              autofocus: true,
              controller: caloriesBurnedPerHourController,
              decoration: const InputDecoration(
                labelText: 'Estimated Calories Burned Per Hour',
              ),
            ),
            ListTile(
              onTap: () {
                _showBodyPartDialog(context, exerciseData, bodyParts);
              },
              title: Column(
                children: [
                  const Text("Target Body Part"),
                  Text(bodyParts.toString()),
                ],
              ),
              trailing: const Icon(Icons.add),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Exercise Type"),
                DropdownButton<int>(
                  value: 1,
                  items: exerciseType.entries
                      .map((e) => DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          ))
                      .toList(),
                  onChanged: (int? value) {
                    print(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBodyPartDialog(
      BuildContext context, Map<int, String> exerciseData, List bodyParts) {
    showDialog(
      context: context,
      builder: (context) {
        return BodyPartDialog(exerciseData: exerciseData, bodyParts: bodyParts);
      },
    );
  }
}

class BodyPartDialog extends StatefulWidget {
  final Map<int, String> exerciseData;
  final List bodyParts;
  // final VoidCallback? onSelected;

  const BodyPartDialog({
    Key? key,
    required this.exerciseData,
    required this.bodyParts,
  }) : super(key: key);

  @override
  _BodyPartDialogState createState() => _BodyPartDialogState();
}

class _BodyPartDialogState extends State<BodyPartDialog> {
  late List<bool> selectedBodyParts;

  @override
  void initState() {
    super.initState();
    selectedBodyParts =
        List.generate(widget.exerciseData.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Target Body Parts'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= widget.exerciseData.length; i++)
            CheckboxListTile(
              value: widget.bodyParts.contains(widget.exerciseData[i]),
              onChanged: (bool? value) {
                log(value.toString());
                log(widget.exerciseData[i]!);
                if (value == true) {
                  setState(() {
                    widget.bodyParts.add(widget.exerciseData[i]);
                  });
                } else {
                  setState(() {
                    widget.bodyParts.remove(widget.exerciseData[i]);
                  });
                }
              },
              title: Text(widget.exerciseData[i]!),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}
