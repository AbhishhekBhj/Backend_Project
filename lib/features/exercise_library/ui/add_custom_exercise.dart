import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import "dart:io";

class AddCustomExercise extends StatefulWidget {
  const AddCustomExercise({Key? key}) : super(key: key);

  @override
  State<AddCustomExercise> createState() => _AddCustomExerciseState();
}

class _AddCustomExerciseState extends State<AddCustomExercise> {
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.camera, context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery, context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      } else {
        showNoImageSelectedDialog(context);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to pick image. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void showNoImageSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Image Selected'),
          content: const Text('Please select an image to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  File? imageFile;

  @override
  void initState() {
    super.initState();
    isProMember = UserDataManager.userData['is_pro_member'];
  }

  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController caloriesBurnedPerHourController =
      TextEditingController();

  TextEditingController exerciseDescriptionController = TextEditingController();

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
    4: 'Hamstrings',
    5: 'Glutes Maximus',
    6: 'Lower Back',
    7: 'Lats',
    8: 'Chest',
    9: 'Forearms',
    10: 'Biceps',
    11: 'Triceps',
    12: 'Calves',
    13: 'Abs',
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
          title: const Text('Add Custom  Exercise'),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            GestureDetector(
              onTap: () {
                showImagePicker(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: Get.width * 0.5,
                height: Get.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: imageFile == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 50,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(imageFile!),
                              fit: BoxFit.fitHeight),
                        ),
                      ),
              ),
            ),
            TextFormField(
              controller: exerciseNameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              autofocus: true,
              controller: caloriesBurnedPerHourController,
              decoration: const InputDecoration(
                labelText: 'Estimated Calories Burned Per Hour',
              ),
            ),
            TextFormField(
              autofocus: true,
              controller: exerciseDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Small Description of Exercise',
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
            GestureDetector(
              onTap: () => Fluttertoast.showToast(msg: "Exercise Added"),
              child: Container(
                height: 60,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    'Add Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
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
