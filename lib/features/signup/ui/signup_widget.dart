import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/features/login/ui/login_widget.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/signup/ui/textfield_widget.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_widget.dart';
import 'package:mygymbuddy/texts/texts.dart';

class SignupForm extends StatelessWidget {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String selectedActivityLevel = UserModelFormFields.activityLevels[0];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Build your signup form UI components based on the state
    // You can access the BLoC's state and use it to update the UI
    return Scaffold(
      appBar: AppBar(
          title: Text(
            appName,
            style: textTheme.headlineMedium,
          ),
          centerTitle: true,
          backgroundColor: MyColors.accentPurple),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          UpperWelcome(textTheme: textTheme),
          SizedBox(
            height: 15,
          ),
          LowerWelcome(textTheme: textTheme,subTitle: welcome,),
          Container(
            padding: EdgeInsets.all(20.0),
            child: UserModelFormFields(
                fullNameController: fullNameController,
                fullNameLabel: fullNameLabel,
                fullNameHintText: fullNameHintText,
                emailController: emailController,
                emailLabel: emailAddressLabel,
                emailHintText: emailAddressHintText,
                phoneNumberController: phoneNumberController,
                phoneNumberLabel: phoneNumberLabel,
                phoneNumberHintText: phoneNumberHintText,
                usernameController: usernameController,
                usernameLabel: usernameLabel,
                usernameHintText: usernameHintText,
                passwordController: passwordController,
                passwordLabel: passwordLabel,
                passwordHintText: passwordHintText,
                selectedActivityLevel: selectedActivityLevel,
                ageController: ageController,
                ageLabel: ageLabel,
                ageHintText: ageHintText),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.darkPurple,
              side: BorderSide(width: 3, color: Colors.brown),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(20),
            ),
            child: Text(
              signup,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.25),
            child: GestureDetector(
              child: Text(alreadyHaveAccount),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginWidget()), // Navigate to the Login page
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
