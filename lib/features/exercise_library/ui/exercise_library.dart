import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/exercise_library/exercise_details.dart';

class ExerciseLibrary extends StatefulWidget {
  ExerciseLibrary({Key? key}) : super(key: key);

  @override
  _ExerciseLibraryState createState() => new _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  TextEditingController editingController = TextEditingController();

  List<String> duplicateItems = [
    "Push-ups",
    "Sit-ups",
    "Squats",
    "Lunges",
    "Planks",
    "Jumping Jacks",
    "Burpees",
    "Mountain Climbers",
    "High Knees",
    "Running",
    "Bicycling",
    "Swimming",
    "Jump Rope",
    "Dumbbell Bench Press",
    "Dumbbell Rows",
    "Deadlifts",
    "Bench Press",
    "Lat Pulldowns",
    "Leg Press",
    "Leg Curls",
    "Leg Extensions",
    "Dumbbell Lunges",
    "Barbell Curls",
    "Tricep Dips",
    "Pull-ups",
    "Incline Bench Press",
    "Shoulder Press",
    "Leg Raises",
    "Russian Twists",
    "Hip Thrusts",
    "Leg Raises",
    "Kettlebell Swings",
    "Box Jumps",
    "Wall Sits",
    "Leg Blasters",
    "Step-ups",
    "Ab Rollouts",
    "Farmer's Walk",
    "Skull Crushers",
    "Hammer Curls",
    "Preacher Curls",
    "Cable Crossovers",
    "Seated Rows",
    "Front Squats",
    "Box Squats",
    "Hack Squats",
    "Power Cleans",
    "Romanian Deadlifts",
    "Bent-over Rows",
    "Bicycle Crunches",
    "Spiderman Push-ups",
    "Diamond Push-ups",
    "Close-grip Bench Press",
    "Overhead Squats",
    "Medicine Ball Slams",
    "Bulgarian Split Squats",
    "Leg Press Calf Raises",
    "Plank Shoulder Taps",
    "Side Planks",
    "Back Extensions",
    "Leg Pull-ins",
    "Decline Push-ups",
    "Superman",
    "Windshield Wipers",
    "Russian Twists",
    "Barbell Shrugs",
    "Cable Crunches",
    "Lateral Raises",
    "Kettlebell Lunges",
    "Tricep Kickbacks",
    "Russian Twists",
    "Glute Bridges",
    "Lat Raises",
    "Tricep Extensions",
    "Bicycle Crunches",
    "Donkey Kicks",
    "Wall Angels",
    "Plank Jacks",
    "Flutter Kicks",
    "Turkish Get-ups",
    "Scissor Kicks",
    "Russian Twists",
    "Thrusters",
    "Medicine Ball Throws",
    "V-ups",
    "Hindu Push-ups",
    "Jumping Squats",
    "Battle Ropes",
    "Cable Rows",
    "Pec Deck Flyes",
    "Smith Machine Squats",
    "Seated Leg Curls",
    "Pull-ups",
    "Box Jumps",
    "Diamond Push-ups",
    "Mountain Climbers",
    "Superman",
    "Russian Twists",
  ];

  var items = <String>[];

  @override
  void initState() {
    items = duplicateItems;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: Get.height * 0.1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search for Exercise",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(ExerciseDetails(
                        exerciseName: items[index],
                      ));
                    },
                    title: Text(
                      '${index + 1}. ${items[index]}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
