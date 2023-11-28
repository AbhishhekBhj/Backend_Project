import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/features/login/ui/login.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/signup/ui/textfield_widget.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_widget.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'dart:developer';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  XFile? image;

  final SignupBloc signupBloc = SignupBloc();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  Future pickImageFromCamera() async {
    var img;
    try {
      img = await ImagePicker().pickImage(source: ImageSource.camera);
    } catch (e) {
      if (e is PlatformException) {
        // Handle platform exceptions
        log(e.toString());

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred: ${e.message}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      if (img != null) {
        image = img;
      }
    });
  }

  Future pickImageFromGallery() async {
    var img;
    try {
      img = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (e is PlatformException) {
        // Handle platform exceptions
        log(e.toString());

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred: ${e.message}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      if (img != null) {
        image = img;
      }
    });
  }

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
      body: BlocConsumer<SignupBloc, SignupState>(
        bloc: signupBloc,
        listenWhen: (previous, current) => current is SignupActionState,
        buildWhen: (previous, current) => current is! SignupActionState,
        listener: (context, state) {
          if (state is SignupSuccessState || state is SignupNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ));
          }
        },
        builder: (context, state) {
          print(state);
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
                        usernameController: usernameController,
                        passwordController: passwordController,
                        ageController: ageController,
                        fullNameLabel: fullNameLabel,
                        emailLabel: emailAddressLabel,
                        usernameLabel: usernameLabel,
                        passwordLabel: passwordLabel,
                        ageLabel: ageLabel,
                        fullNameHintText: fullNameHintText,
                        emailHintText: emailAddressHintText,
                        usernameHintText: usernameHintText,
                        passwordHintText: passwordHintText,
                        ageHintText: ageHintText),
                    IconButton(
                        onPressed: () {
                          showAlert();
                        },
                        icon: Icon(Icons.camera)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: MyColors.accentPurple),
                      onPressed: () {
                        signupBloc.add(SignUpClickedButtonEvent(
                            userModel: UserModel(
                                email: emailController.text,
                                name: fullNameController.text,
                                age: ageController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                                image: image)));
                      },
                      child: Text(signup),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: InkWell(
                        child:
                            Text("Click here if you already have an Account?"),
                        onTap: () =>
                            signupBloc.add(RedirectLoginPageClickedEvent()),
                      ),
                    )
                  ],
                ),
              );

            case SignupSuccessState:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));

            case SignupNavigationState:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));

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

          return Scaffold(
            body: Container(
              child: Text("ABc"),
            ),
          );
        },
      ),
    );
  }

  void showAlert() {
    // Schedule the showAlert method to run after the build phase is complete
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Select Image Source"),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickImageFromGallery();
                  },
                  child: Row(
                    children: [Icon(Icons.image), Text("Gallery")],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickImageFromCamera();
                  },
                  child: Row(
                    children: [Icon(Icons.camera), Text("Camera")],
                  ),
                ),
              ]),
            ),
          );
        },
      );
    });
  }
}
