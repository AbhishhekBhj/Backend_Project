import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/calories/ui/calories.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/features/home/ui/homee.dart';
import 'package:mygymbuddy/features/home/ui/other_features.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_update.dart';
import 'package:mygymbuddy/features/meditate/ui/meditate.dart';

class BaseClass extends StatefulWidget {
  BaseClass({super.key, this.indexNum});

  int? indexNum;
  @override
  State<BaseClass> createState() => _BaseClassState();
}

class _BaseClassState extends State<BaseClass> {
  @override
  Widget build(BuildContext context) {
    int? _selectedIndex = (widget.indexNum == null) ? 0 : widget.indexNum;

    setState(() {});
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Scaffold(
              backgroundColor: Colors.grey[50],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: BottomNavigationBar(
                      backgroundColor: Colors.black,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: _selectedIndex!,
                      selectedItemColor: MyColors.darkBlue,
                      selectedFontSize: 15,
                      unselectedItemColor: Colors.grey,
                      onTap: _onItemTapped,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.plateWheat),
                            label: "Log Food"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              FontAwesomeIcons.dumbbell,
                            ),
                            label: "Workout"),
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.clock),
                            label: "Meditate"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.menu), label: "More Options")
                      ],
                    ),
                  ),
                ),
              ),
              body: IndexedStack(
                index: _selectedIndex,
                children: [
                  HomePage(),
                  CaloricInformation(),
                  UpdateMeasurements(),
                  StartMeditation(),
                  OtherFeaturePage()
                ],
              ));
        }

        return Scaffold(
          body: Center(child: Text("Error Laoding")),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.indexNum = index;
    });
  }
}
