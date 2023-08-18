import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/signup/ui/textfield_widget.dart';
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
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          // Build your signup form UI components based on the state
          // You can access the BLoC's state and use it to update the UI
          return Scaffold(
            // appBar: AppBar(
            //     title: Text(
            //       appName,
            //       style: textTheme.displayMedium,
            //     ),
            //     centerTitle: true,
            //     backgroundColor: MyColors.accentPurple),
            body: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName,
                          style: textTheme.headlineSmall,
                        ),
                        SizedBox(
                            height: 1), // Add some spacing between the texts
                        Text(
                          idealBuddy,
                          style: textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: MyColors.lightPurple,
                          height: 200.0,
                          width: double.infinity,
                          child: Text("Insert some picture here later"),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: Column(
                  children: [
                    Text(
                      welcomeText,
                      style: textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      welcome,
                      style: textTheme.labelLarge,
                    )
                  ],
                )),
                UserModelFormFields(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    phoneNumberController: phoneNumberController,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    selectedActivityLevel: selectedActivityLevel,
                    ageController: ageController)
              ],
            ),
          );
        },
      ),
    );
  }
}
