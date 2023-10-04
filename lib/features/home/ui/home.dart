import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi_ui.dart';
import 'package:mygymbuddy/features/calories/ui/calories.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/features/measurements/ui/measurements_update.dart';
import 'package:mygymbuddy/features/meditate/ui/meditate.dart';
import 'package:mygymbuddy/features/reminder/ui/reminders.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc(); // Create an instance of the home bloc

  @override
  void initState() {
    homebloc.add(HomeInitalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToBmiPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BMI(),
              ));
        } else if (state is HomeNavigateToCaloriesPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaloricInformation(),
              ));
        } else if (state is HomeNavigateToDrinkWaterPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaloricInformation(),
              ));
        } else if (state is HomeNavigateToMeasurementsPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateMeasurements(),
              ));
        } else if (state is HomeNavigateToWorkoutPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartMeditation(),
              ));
        } else if (state is HomeNavigateToRemindersPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Reminders(),
              ));
        } else if (state is HomeNavigateToMeasurementsPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateMeasurements(),
              ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(color: Colors.amber),
            ));
          case HomeLoadedSuccessState:
            return HomeWidget(homebloc: homebloc, textTheme: textTheme);
          case HomeErrorState:
            return Scaffold(
                body: Center(
                    child: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            )));

          default:
            return HomeWidget(homebloc: homebloc, textTheme: textTheme);
        }
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.homebloc,
    required this.textTheme,
  });

  final HomeBloc homebloc;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            onTabChange: (value) {
              if (value == 1) {
                homebloc.add(DietTrackerClickedEvent());
              }
              if (value == 2) {
                // homebloc.add()
              }
            },
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            backgroundColor: Colors.black,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            gap: 5,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.tapas_rounded,
                text: 'Diet Tracker',
              ),
              GButton(
                icon: Icons.watch_later_outlined,
                text: 'Start Workout',
              ),
              GButton(
                icon: Icons.menu,
                text: 'More Features',
              ),
            ],
          ),
        ),
      ),
      body: FeaturesWidget(
        textTheme: textTheme,
        homeBloc: homebloc,
      ),
    );
  }
}
