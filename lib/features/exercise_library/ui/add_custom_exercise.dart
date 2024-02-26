import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import 'package:mygymbuddy/widgets/image_picker_widget.dart';
import "dart:io";

class AddCustomExercise extends StatefulWidget {
  const AddCustomExercise({Key? key}) : super(key: key);

  @override
  State<AddCustomExercise> createState() => _AddCustomExerciseState();
}

class _AddCustomExerciseState extends State<AddCustomExercise> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    isProMember = UserDataManager.userData['is_pro_member'];
  }

  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController caloriesBurnedPerHourController =
      TextEditingController();

  List<String> bodyParts = [];

  late bool isProMember;

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
    2: 'Rear Delts',
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Custom Exercise'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const Text('Add Custom Exercise'),
            PickImageWidget(
              isProMember: isProMember,
              onImageCropped: (File image) {
                setState(() {
                  imageFile = image;
                });
              },
            ),
            TextFormField(
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
                _showBodyPartDialog(context);
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
                const Text("Exercise Type"),
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

  void _showBodyPartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BodyPartDialog(
          exerciseData: exerciseData,
          initialBodyParts: bodyParts,
          onBodyPartsChanged: (List<String> updatedBodyParts) {
            setState(() {
              bodyParts = updatedBodyParts;
            });
          },
        );
      },
    );
  }
}

class BodyPartDialog extends StatefulWidget {
  final Map<int, String> exerciseData;
  final List<String> initialBodyParts;
  final Function(List<String>) onBodyPartsChanged;

  const BodyPartDialog({
    Key? key,
    required this.exerciseData,
    required this.initialBodyParts,
    required this.onBodyPartsChanged,
  }) : super(key: key);

  @override
  _BodyPartDialogState createState() => _BodyPartDialogState();
}

class _BodyPartDialogState extends State<BodyPartDialog> {
  late List<String> bodyParts;

  @override
  void initState() {
    super.initState();
    bodyParts = List.from(widget.initialBodyParts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Target Body Parts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.exerciseData.length,
              itemBuilder: (BuildContext context, int index) {
                final int key = widget.exerciseData.keys.elementAt(index);
                final String value = widget.exerciseData[key]!;
                return CheckboxListTile(
                  value: bodyParts.contains(value),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        bodyParts.add(widget.exerciseData[key]!);
                      } else {
                        bodyParts.remove(widget.exerciseData[key]!);
                      }
                      widget.onBodyPartsChanged(bodyParts);
                    });
                  },
                  title: Text(value),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
