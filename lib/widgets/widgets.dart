import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/home/ui/drawer.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/bloc/home_bloc.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appName),
      centerTitle: true,
      backgroundColor: MyColors.accentPurple,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
    required this.usernameController,
    required this.usernameLabel,
    required this.usernameHintText,
    required this.passwordController,
    required this.passwordLabel,
    required this.passwordHintText,
  });

  final TextEditingController usernameController;
  final String usernameLabel;
  final String usernameHintText;
  final TextEditingController passwordController;
  final String passwordLabel;
  final String passwordHintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
              labelText: usernameLabel, hintText: usernameHintText),
        ),
        const SizedBox(height: 2.0),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: passwordLabel, hintText: passwordHintText),
        ),
      ],
    );
  }
}

class FeaturesWidget extends StatelessWidget {
  FeaturesWidget({
    Key? key,
    required this.textTheme,
    required this.homeBloc,
  }) : super(key: key);

  final HomeBloc homeBloc;
  final TextTheme textTheme;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: CommonAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
          child: GridView.count(
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 20.0, // Spacing between columns
            mainAxisSpacing: 20.0, // Spacing between rows
            children: [
              FeatureCard(
                image: aWorkout,
                title: aStartWorkoutTitle,
                subTitle: aStartWorkoutSubTitle,
                onTap: () {
                  homeBloc.add(StartWorkoutClickedEvent());
                },
              ),
              FeatureCard(
                image: aCalories,
                title: aCaloriesTitle,
                subTitle: aCaloriesSubTitle,
                onTap: () {
                  homeBloc.add(DietTrackerClickedEvent());
                },
              ),
              FeatureCard(
                image: aReminder,
                title: aRemindersTitle,
                subTitle: aRemindersSubTitle,
                onTap: () {
                  homeBloc.add(RemindersClickedEvent());
                },
              ),
              FeatureCard(
                image: aGlass,
                title: aDrinkWaterTitle,
                subTitle: aDrinkWaterSubTitle,
                onTap: () {
                  homeBloc.add(DrinkWaterClickedEvent());
                },
              ),
              FeatureCard(
                image: aBmi,
                title: aBmiTitle,
                subTitle: aBmiSubTitle,
                onTap: () {
                  homeBloc.add(BmiClickedEvent());
                },
              ),
              FeatureCard(
                image: aTape,
                title: aMeasurementTitle,
                subTitle: aMeasurementSubTitle,
                onTap: () {
                  homeBloc.add(MeasurementsClickedEvent());
                },
              ),
              FeatureCard(
                  image: aExerciseGallery,
                  title: aExerciseGalleryTitle,
                  subTitle: aExerciseGallerySubTitle),
              FeatureCard(
                  image: aMeditate,
                  title: aMeditateTitle,
                  subTitle: aMeditateSubTitle)
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  const FeatureCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.darkBlue, width: 3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
            Text(
              subTitle,
              style: textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
