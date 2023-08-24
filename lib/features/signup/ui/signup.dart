import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/signup/ui/textfield_widget.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_widget.dart';
import 'package:mygymbuddy/texts/texts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignupBloc signupBloc = SignupBloc();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    signupBloc.add(SignupInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.accentPurple,
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        bloc: signupBloc,
        listenWhen: (previous, current) => current is SignupActionState,
        buildWhen: (previous, current) => current is! SignupActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case SignupLoadingState:
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.grey),
              );

            case SignupInitial:
              return Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    UpperWelcome(textTheme: textTheme),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    LowerWelcome(
                      textTheme: textTheme,
                      subTitle: welcome,
                    ),
                    UserModelFormFields(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        phoneNumberController: phoneNumberController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        ageController: ageController,
                        fullNameLabel: fullNameLabel,
                        emailLabel: emailAddressLabel,
                        phoneNumberLabel: phoneNumberLabel,
                        usernameLabel: usernameLabel,
                        passwordLabel: passwordLabel,
                        ageLabel: ageLabel,
                        fullNameHintText: fullNameHintText,
                        emailHintText: emailAddressHintText,
                        phoneNumberHintText: phoneNumberHintText,
                        usernameHintText: usernameHintText,
                        passwordHintText: passwordHintText,
                        ageHintText: ageHintText),
                    FloatingActionButton(
                      onPressed: () {
                        print("Full Name: ${fullNameController.text}");
                        print("Email: ${emailController.text}");
                        print("Phone Number: ${phoneNumberController.text}");
                        print("Username: ${usernameController.text}");
                        print("Password: ${passwordController.text}");
                        print("Age: ${ageController.text}");

                        signupBloc.add(SignUpClickedButtonEvent(
                            userModel: UserModel(
                                age: ageController.text,
                                email: emailController.text,
                                name: fullNameController.text,
                                password: passwordController.text,
                                phoneNumber: phoneNumberController.text,
                                username: usernameController.text)));
                      },
                      child: Text(signup),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: GestureDetector(
                        child:
                            Text("Click here if you already have an Account?"),
                      ),
                    )
                  ],
                ),
              );
            case SignupLoadingState:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case SignupSuccessState:
              return Container(
                child: Center(
                  child: Text("Nice"),
                ),
              );

            case SignupErrorState:
              return Container(
                child: Center(
                  child: Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
