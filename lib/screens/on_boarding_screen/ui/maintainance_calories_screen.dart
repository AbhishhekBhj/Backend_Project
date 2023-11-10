import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';

class MaintainanceCaloriesPage extends StatefulWidget {
  const MaintainanceCaloriesPage({Key? key}) : super(key: key);

  @override
  State<MaintainanceCaloriesPage> createState() =>
      _MaintainanceCaloriesPageState();
}

class _MaintainanceCaloriesPageState extends State<MaintainanceCaloriesPage> {
  Map<int, bool> selectedGenders = {1: false, 2: false};
  Map<int, String> genders = {1: "MAN", 2: "WOMAN"};

  String defaultDropdownValue = 'Level0: Basal Metabolic Rate(BMR)';
  var levels = [
    'Level0: Basal Metabolic Rate(BMR)',
    'Level1: little or no exercise',
    'Level2: exercise weekly',
    'Level3: exercise weekly',
    'Level4: intense exercise weekly',
    'Level5: intense exercise weekly',
    'Level6: very intense exercise daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Text(
              "FITNESS DETAILS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: "Enter your height in cms",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: "Enter your weight in kgs",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6),
            selectGenderButton(),
            SizedBox(height: 6),
            DropdownButton(
              hint: Text("Select Activity Level"),
              value: defaultDropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: levels.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  defaultDropdownValue = newValue!;
                });
              },
            ),
            SizedBox(height: 6),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: MyColors.lightPurple,
                ),
                onPressed: () {
                  //TODO: Send Data for Calculating Maintainace Calories
                },
                child: Text("Confirm Data"))
          ],
        ),
      ),
    );
  }

  Column selectGenderButton() {
    return Column(
      children: genders.entries.map((entry) {
        final genderKey = entry.key;
        final genderValue = entry.value;

        return GenderButton(
          text: genderValue,
          onPressed: () {
            log(genderValue);

            // Update the selected genders map.
            setState(() {
              selectedGenders.updateAll((key, value) => value = false);
              selectedGenders[genderKey] = true;
            });

            log(genderValue);
          },
          isSelected: selectedGenders[genderKey]!,
        );
      }).toList(),
    );
  }
}

class GenderButton extends StatefulWidget {
  const GenderButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  _GenderButtonState createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        child: Text(widget.text),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: BorderSide(
              color: widget.isSelected ? Colors.blue : Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: widget.isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
