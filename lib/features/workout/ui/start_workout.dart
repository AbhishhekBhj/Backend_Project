import 'package:flutter/material.dart';
import 'package:mygymbuddy/data/models/exercise_entry.dart';

class WorkoutLoggingPage extends StatefulWidget {
  const WorkoutLoggingPage({super.key});

  @override
  _WorkoutLoggingPageState createState() => _WorkoutLoggingPageState();
}

class _WorkoutLoggingPageState extends State<WorkoutLoggingPage> {
  TextEditingController exerciseController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  List<ExerciseEntry> workoutEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Logging'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Exercise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: exerciseController,
              decoration: InputDecoration(labelText: 'Exercise'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: setsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Sets'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: repsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Reps'),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kgs)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                  foregroundColor: Colors.black),
              onPressed: () {
                print('exercise add');
                //ToDO: store all the exercise value in json post it to the backend
                addExercise();
              },
              child: Text('Add Exercise'),
            ),
            SizedBox(height: 16),
            Text(
              'Workout Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              //use the list and build the workout summary
              child: ListView.builder(
                itemCount: workoutEntries.length,
                itemBuilder: (context, index) {
                  final entry = workoutEntries[index];
                  return ListTile(
                    title: Text(entry.exercise),
                    subtitle: Text(
                        '${entry.sets} sets x ${entry.reps} reps of ${entry.weight} kgs volume = ${(entry.reps * entry.weight).toStringAsFixed(2)} kgs'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addExercise() {
    print('abc');

    final exercise = exerciseController.text;
    final sets = int.tryParse(setsController.text) ?? 0;
    final reps = int.tryParse(repsController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0.0;

    if (exercise.isNotEmpty && sets > 0 && reps > 0 && weight > 0.0) {
      //create instance to add workout
      final workoutEntry = ExerciseEntry(exercise, sets, reps, weight);
      final dateTime = DateTime.now();
      setState(() {
        //add the instance in the list
        workoutEntries.add(workoutEntry);

        final workoutData =
            WorkoutEntry(dateTime: dateTime, exercises: workoutEntries);
//convert the data to json
        final jsonData = workoutData.toJson();

        print(jsonData.toString());

        // Clear input fields
        exerciseController.clear();
        setsController.clear();
        repsController.clear();
        weightController.clear();
      });
    }
  }
}
