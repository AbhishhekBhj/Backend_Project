import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/data/models/bmi_model.dart';
import 'package:mygymbuddy/features/bmi/bloc/bmi_bloc.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  @override
  void initState() {
    // TODO: implement initState
    bmiBloc.add(BMIInitialEvent());
    super.initState();
  }

  final BmiBloc bmiBloc = BmiBloc();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  double bmiValue = 0.0;
  String bmiCategory = "";
  bool dialog = false;
  List<dynamic> bmiData = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiBloc, BmiState>(
        bloc: bmiBloc,
        buildWhen: (previous, current) => current is! BMIActionState,
        listener: (context, state) {},
        builder: (context, state) {
          print(state.runtimeType);
          if (state is BMILoadingState) {
            return Scaffold(
              backgroundColor: Colors.grey[100],
              body: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            );
          }
          if (state is BMISuccessState) {
            bmiData = state.bmiData;
            dialog = state.isDialog;
          }

          return GestureDetector(
            onTap: () {
              dialog
                  ? {
                      bmiBloc.add(BMIInitialEvent()),
                      setState(() {
                        dialog = false;
                      })
                    }
                  : () {};
            },
            child: Scaffold(
              appBar: CommonAppBar(),
              body: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Enter Weight in Kgs"),
                          ),
                          TextField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Enter Height in Metres"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              bmiBloc.add(CalculateBMIClickedEvent(
                                  bmiModel: BMIModel(
                                      heightInMetre:
                                          double.parse(heightController.text),
                                      weightInKg: double.parse(
                                          weightController.text))));
                            },
                            child: Text("Calculate BMI"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  dialog
                      ? Positioned(
                          top: 70,
                          child: Container(
                            height: 200,
                            child: AlertDialog(
                              title: Text('BMI Calculated'),
                              content: Column(
                                children: [
                                  Text("Your BMI is ${bmiData[0]}"),
                                  Text("You are ${bmiData[1]}")
                                ],
                              ),
                            ),
                          ))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        });
  }
}
