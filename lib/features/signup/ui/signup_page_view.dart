import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';

import 'singup pages/enter_email.dart';
import 'singup pages/enter_name.dart';
import 'singup pages/enter_password.dart';
import 'singup pages/enter_username.dart';

class SignupPageView extends StatefulWidget {
  const SignupPageView({super.key});

  @override
  State<SignupPageView> createState() => _SignupPageViewState();
}

class _SignupPageViewState extends State<SignupPageView> {
  // controller for the pageview
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  // current page index
  int _currentPage = 0;

// progress bar value
  double _progress = 0;

  SignupBloc signupBloc = SignupBloc();
  @override
  void initState() {
    _progress = 1 / 8;
    // TODO: implement initState
    super.initState();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bodyWeightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

// goal of the user
  String goal = "";
// gender of the user
  String gender = "";
// profile picture of the user
  String profilePicture = "";
// activity level of the user
  String activityLevel = "";

// check if the name is valid
  bool isValidName = true;
  bool isValidEmail = true;
  bool isValidUsername = true;
  bool isValidPassword = true;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (_currentPage == 0) {
                Navigator.pop(context);
              } else {
                _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              }
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              minHeight: 6.0,
              color: Colors.black,
            ),
            SizedBox(
              height: screenHeight * 0.85,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int value) {
                  setState(() {
                    // update the current page value to the new page value
                    _currentPage = value;
                    // update the progress bar value
                    _progress = (value + 1) / 8;
                  });
                },
                controller: _pageController,
                children: [
                  KeepAlivePage(
                      child: EnterName(
                    isValidName: isValidName,
                    nameController: fullNameController,
                    onChanged: () {
                      checkNameValidity(fullNameController.text);
                    },
                  )),
                  KeepAlivePage(
                      child: EnterEmail(
                    emailController: emailController,
                    isValidEmail: isValidEmail,
                    onChanged: () {
                      checkEmailValidation(emailController.text);
                    },
                  )),
                  KeepAlivePage(
                      child: EnterUsername(
                    usernameController: usernameController,
                    isValidUsername: isValidUsername,
                    onChanged: () {
                      checkUsernameValidity(usernameController.text);
                    },
                  )),
                  KeepAlivePage(
                      child: EnterPassword(
                    passwordController: passwordController,
                    isValidPassword: isValidPassword,
                    onChanged: () {
                      checkPasswordValidity(passwordController.text);
                    },
                  )),
                  KeepAlivePage(
                      child: Scaffold(
                    body: Center(
                      child: Text("hello to my page"),
                    ),
                  )),
                  KeepAlivePage(
                      child: Scaffold(
                    body: Center(
                      child: Text("hello to my page"),
                    ),
                  )),
                  KeepAlivePage(
                      child: Scaffold(
                    body: Center(
                      child: Text("hello to my page"),
                    ),
                  )),
                  KeepAlivePage(
                      child: Scaffold(
                    body: Center(
                      child: Text("hello to my page"),
                    ),
                  )),
                ],
              ),
            ),
          ],
        )),
        bottomSheet: CustomButton(
            text: "NEXT",
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            }),
      ),
    );
  }

  bool checkNameValidity(String name) {
    if (name.length < 4) {
      setState(() {
        isValidName = false;
      });
      return false;
    } else {
      setState(() {
        isValidName = true;
      });
      return true;
    }
  }

  bool checkUsernameValidity(String username) {
    // Check if the username is greater than 6 characters and contains at least one number
    if (username.length <= 6 || !RegExp(r'\d').hasMatch(username)) {
      setState(() {
        isValidUsername = false;
      });
      return false;
    }

    // If both conditions are met, set isValidUsername to true and return true
    setState(() {
      isValidUsername = true;
    });

    return true;
  }

  void checkEmailValidation(String value) {
    bool isValid = EmailValidator.validate(value);

    if (isValid) {
      setState(() {
        isValidEmail = true;
      });
    } else {
      setState(() {
        isValidEmail = false;
      });
    }
  }

  bool checkPasswordValidity(String value) {
    // Minimum length check
    bool isLengthValid = value.length >= 8;

    // Check for at least one uppercase letter
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));

    // Check for at least one lowercase letter
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));

    // Check for at least one digit
    bool hasDigit = value.contains(RegExp(r'[0-9]'));

    bool hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Checking all conditions
    bool isValidPassword = isLengthValid &&
        hasUppercase &&
        hasLowercase &&
        hasSpecialChar &&
        hasDigit;

    setState(() {
      this.isValidPassword = isValidPassword;
    });
    if (isValidPassword) {
      return true;
    } else {
      return false;
    }
  }
}

// describe the  KeepAlivePage class
/*
  This class is used to keep the state of the page alive
  It takes one parameter
  1. child
  It returns a widget
  This widget is used to keep the state of the page alive
*/
class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    required this.child,
  });

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          screenSize.width / 8, 0, screenSize.width / 8, 50),
      child: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.08,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
    );
  }
}
