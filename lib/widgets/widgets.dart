import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/texts/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/bloc/home_bloc.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appName),
      centerTitle: true,
      backgroundColor: MyColors.accentPurple,
    );
  }
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
        SizedBox(height: 2.0),
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('username');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
            icon: Icon(Icons.menu),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            appName,
            style: textTheme.headlineMedium,
          ),
          centerTitle: true,
          backgroundColor: MyColors.accentPurple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        FeatureCard(
                          image: aWorkout,
                          title: "Start Workout",
                          subTitle: "Start Your Workout",
                          onTap: () {
                            homeBloc.add(StartWorkoutClickedEvent());
                          },
                        ),
                        FeatureCard(
                          image: aCalories,
                          title: "Diet Tracker",
                          subTitle: "Track Your Calories",
                          onTap: () {
                            homeBloc.add(DietTrackerClickedEvent());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        FeatureCard(
                          image: aReminder,
                          title: "Reminders",
                          subTitle: "Set Reminders",
                          onTap: () {
                            homeBloc.add(RemindersClickedEvent());
                          },
                        ),
                        FeatureCard(
                          image: aGlass,
                          title: "Drink Water",
                          subTitle: "Add Water Drank",
                          onTap: () {
                            homeBloc.add(DrinkWaterClickedEvent());
                          },
                        ),
                        FeatureCard(
                          image: aBmi,
                          title: "BMI",
                          subTitle: "Calculate Your BMI",
                          onTap: () {
                            homeBloc.add(BmiClickedEvent());
                          },
                        ),
                        FeatureCard(
                          image: aTape,
                          title: "Measurement",
                          subTitle: "Set measurements",
                          onTap: () {
                            homeBloc.add(BmiClickedEvent());
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.darkBlue, width: 3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(
              title,
              style: textTheme.headlineSmall,
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
