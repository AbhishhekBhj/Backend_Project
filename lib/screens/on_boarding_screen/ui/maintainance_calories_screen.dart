import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';

class MaintainanceCaloriesPage extends StatefulWidget {
  const MaintainanceCaloriesPage({Key? key}) : super(key: key);

  @override
  State<MaintainanceCaloriesPage> createState() =>
      _MaintainanceCaloriesPageState();
}

class _MaintainanceCaloriesPageState extends State<MaintainanceCaloriesPage> {
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
      backgroundColor: Colors.grey[100],
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
              // keyboardType: TextInputType.number,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: "Enter your height in cms",
                border: OutlineInputBorder(),
              ),
              // Add validation logic here
            ),
            SizedBox(height: 6),
            TextFormField(
              // keyboardType: TextInputType.number,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: "Enter your weight in kgs",
                border: OutlineInputBorder(),
              ),
              // Add validation logic here
            ),
            SizedBox(height: 6),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your gender",
                border: OutlineInputBorder(),
              ),
              // Add validation logic here
            ),
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
                child: Text("Submit Data"))
          ],
        ),
      ),
    );
  }
}
