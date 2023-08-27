import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/features/bmi/ui/bmi.dart';
import 'package:mygymbuddy/features/calories/ui/calories.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';

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
                builder: (context) => BMICalculator(),
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
                builder: (context) => CaloricInformation(),
              ));
        } else if (state is HomeNavigateToWorkoutPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaloricInformation(),
              ));
        } else if (state is HomeNavigateToRemindersPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaloricInformation(),
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
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              body: FeaturesWidget(
                features: Features.featuresList, // Pass the features list
                textTheme: textTheme,
                homeBloc: homebloc,
              ),
            );
          case HomeErrorState:
            return Scaffold(
                body: Center(
                    child: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            )));

          default:
            return SizedBox();
        }
      },
    );
  }
}
