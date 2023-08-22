import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/data/models/home_features_model.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';

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
            return FeaturesWidget(
                features: successState.featuresModelList,
                successState: successState,
                textTheme: textTheme);

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

class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget({
    super.key,
    required this.features,
    required this.successState,
    required this.textTheme,
  });

  final List<FeatureModel> features;
  final HomeLoadedSuccessState successState;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
        child: Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: features.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.darkBlue, width: 3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: successState.featuresModelList[index].onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(successState.featuresModelList[index].image),
                      Text(
                        successState.featuresModelList[index].title,
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        successState.featuresModelList[index].subtitle,
                        style: textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
