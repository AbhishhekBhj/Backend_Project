import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/exercise_library/exercise_details.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/widgets/custom_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class ExerciseLibrary extends StatefulWidget {
  ExerciseLibrary({Key? key}) : super(key: key);

  @override
  _ExerciseLibraryState createState() => new _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  TextEditingController exerciseController = TextEditingController();

  List<String> exercises = [
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

  late List<SearchFieldListItem> exerciseItem;

  @override
  void initState() {
    exerciseItem =
        exercises.map((e) => SearchFieldListItem(e, child: Text(e))).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            const CustomHeaderWidget(text: "Exercise Gallery"),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
              child: SearchField(
                autoCorrect: true,
                maxSuggestionsInViewPort: 10,
                controller: exerciseController,
                hint: "Enter Exercise Name",
                suggestions: exerciseItem,
                searchInputDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black))),
                onSuggestionTap: (value) {
                  Get.to(ExerciseDetails(
                      exerciseName: value.searchKey.toString()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
