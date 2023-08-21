import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/features/home/ui/features_widget.dart';
import 'package:mygymbuddy/features/signup/ui/signup.dart';
import 'package:mygymbuddy/texts/texts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homebloc.add(HomeInitalEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeBloc homebloc = HomeBloc(); //create instance of the home bloc
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final featuresList = Features.featuresList;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        //listens for states
        if (state is HomeNavigateToBmiPageActionState) {
          // Navigate to BMI page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        } else if (state is HomeNavigateToCaloriesPageActionState) {
          // Navigate to Diet Tracker page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        } else if (state is HomeNavigateToRemindersPageActionState) {
          // Navigate to Reminders page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        } else if (state is HomeNavigateToDrinkWaterPageActionState) {
          // Navigate to Drink Water page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        } else if (state is HomeNavigateToWorkoutPageActionState) {
          // Navigate to Start Workout page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        } else if (state is HomeNavigateToMeasurementsPageActionState) {
          // Navigate to Measurements page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return HomeFeaturesWidget(
                featuresList: featuresList,
                textTheme: textTheme,
                homeBloc: homebloc);

          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text(
                  unExpectedError,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
