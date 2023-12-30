import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/add%20water%20drank/ui/drink_water.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/features/home/ui/homee.dart';
import 'package:mygymbuddy/features/home/ui/other_features.dart';
import 'package:mygymbuddy/features/meditate/ui/meditate.dart';
import 'package:mygymbuddy/features/workout/ui/start_workout.dart';
import 'package:provider/provider.dart';

import '../../../provider/themes/theme_provider.dart';

// Create an instance of HomeBloc
final HomeBloc homeBloc = HomeBloc();

// ignore: must_be_immutable
class BaseClass extends StatefulWidget {
  BaseClass({super.key, this.indexNum});

  int? indexNum;
  @override
  State<BaseClass> createState() => _BaseClassState();
}

class _BaseClassState extends State<BaseClass> {
  @override
  void dispose() {
    // Dispose of the HomeBloc instance when the widget is disposed
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    int? selectedIndex = (widget.indexNum == null) ? 0 : widget.indexNum;

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc, // Use the pre-created HomeBloc instance
      listener: (context, state) {
        // You can add listeners here if needed
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return Scaffold(
            // backgroundColor: Colors.grey[50],
            bottomNavigationBar: Container(
              child: BottomNavigationBar(
                backgroundColor: isDarkMode ? Colors.white30 : Colors.black,
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex!,
                selectedItemColor: isDarkMode ? Colors.black : Colors.white30,
                selectedFontSize: 15,
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.glassWaterDroplet),
                      label: "Drink Water"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.dumbbell,
                      ),
                      label: "Workout"),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.clock), label: "Meditate"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "More Options")
                ],
              ),
            ),
            body: IndexedStack(
              
              index: selectedIndex,
              children: const [
                HomePage(),
                DrinkWater(),
                WorkoutLoggingPage(),
                StartMeditation(),
                OtherFeaturePage()
              ],
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Error Loading Page")),
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
