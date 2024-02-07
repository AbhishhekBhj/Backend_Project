import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSetWidget extends StatefulWidget {
  const AddSetWidget({
    super.key,
    required this.exerciseName,
  });

  final String exerciseName;

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> {
  void deleteSetObjectCallback(int index) {
    setState(() {
      exerciseSetDetailsList.removeAt(index);
    });
  }

  int initalSet = 0;

//this list will be used to store the objects of the exercise set details each object represents each set performed by the user
  List<ExerciseSetDetails> exerciseSetDetailsList = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height / 3,
      child: Column(
        children: [
          Center(
            child: Text(
              widget.exerciseName,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
            width: Get.width * 0.8,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Set"),
                Text("Weight"),
                Text("Reps"),
                Text("Volume"),
                Text("Finish"),
              ],
            ),
          ),
          Column(
            children: [
              for (int i = 0; i < exerciseSetDetailsList.length; i++)
                ExerciseSetDetails(
                  deleteSetObjectCallback: () => deleteSetObjectCallback(i),
                  initalSet: i + 1,
                ),
              Divider()
            ],
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initalSet++;
                exerciseSetDetailsList.add(ExerciseSetDetails(
                  initalSet: initalSet,
                  deleteSetObjectCallback: () => deleteSetObjectCallback(
                      exerciseSetDetailsList.length - 1),
                ));
              });
            },
            child: Container(
              color: Colors.blueAccent,
              height: Get.height * 0.05,
              // width: Get.width * 0.5,
              child: const Center(child: Text("+ Add Set")),
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseSetDetails extends StatefulWidget {
  const ExerciseSetDetails({
    super.key,
    required this.initalSet,
    required this.deleteSetObjectCallback,
  });

  final int initalSet;
  final VoidCallback deleteSetObjectCallback;

  @override
  State<ExerciseSetDetails> createState() => _ExerciseSetDetailsState();
}

class _ExerciseSetDetailsState extends State<ExerciseSetDetails> {
  int volume = 0;
  int weight = 0;
  int reps = 0;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();

  bool isSetComplete = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSetComplete ? Color(0xffA1EEBD) : Colors.white,
      width: Get.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.1,
            child: Center(
              child: Text(widget.initalSet.toString()),
            ),
          ),
          SizedBox(
            width: Get.width * 0.1,
            child: TextFormField(
              onChanged: (value) {
                if (value == "") {
                  setState(() {
                    weight = 0;
                  });
                } else {
                  setState(() {
                    weight = int.parse(value);
                  });
                }
              },
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: Get.width * 0.1,
            child: TextFormField(
              onChanged: (value) {
                if (value == '') {
                  setState(() {
                    reps = 0;
                  });
                } else {
                  setState(() {
                    reps = int.parse(value);
                  });
                }
              },
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: Get.width * 0.1,
            child: Center(
              child: Text("${reps * weight}"),
            ),
          ),
          SizedBox(
            width: Get.width * 0.17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSetComplete = !isSetComplete;
                    });
                  },
                  child: Icon(
                    Icons.check,
                    color: isSetComplete ? Colors.blue : Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.deleteSetObjectCallback(),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
