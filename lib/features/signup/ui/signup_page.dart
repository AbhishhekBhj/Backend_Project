// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/signup/ui/otp.dart';

import '../../../data/models/signup_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Step 1: Declare a TextEditingController for each field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _fitnessGoalController = TextEditingController();
  final TextEditingController _currentFitnessController =
      TextEditingController();

  late SignupBloc _signupBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  void dispose() {
    // Step 4: Dispose of the controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _fitnessGoalController.dispose();
    _currentFitnessController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) => {
          if (state is SignupSuccessState)
            {
              Get.to(OtpVerifyScreen(
                email: _emailController.text,
                signupBloc: _signupBloc,
              ))
            }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller:
                    _usernameController, // Step 3: Attach the controller
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your Username',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _nameController, // Step 3: Attach the controller
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              TextFormField(
                validator: (value) {
                  bool valid = EmailValidator.validate(value!);
                  if (valid == false) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              TextFormField(
                controller: _heightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Height',
                  hintText: 'Enter your height',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  hintText: 'Enter your weight',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your fitness goal';
                  }

                  return null;
                },
                controller: _fitnessGoalController,
                decoration: const InputDecoration(
                  labelText: "Fitness Goal",
                  hintText: 'Enter your fitness goal',
                ),
              ),
              TextFormField(
                controller: _currentFitnessController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current fitness';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Current Fitness",
                  hintText: 'Enter your current fitness',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    log('Signup clicked');

                    _signupBloc.add(SignUpClickedButtonEvent(
                      userModel: UserSignupModel(
                        username: _usernameController.text,
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        height: (_heightController.text),
                        weight: (_weightController.text),
                        age: (_ageController.text),
                        fitnessGoal: (_fitnessGoalController.text),
                        fitnessLevel: (_currentFitnessController.text),
                      ),
                    ));

                    ;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter valid data')),
                    );
                  }
                },
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpVerifyScreen extends StatefulWidget {
  OtpVerifyScreen({
    Key? key,
    required this.email,
    required this.signupBloc,
  }) : super(key: key);

  final String email;
  final SignupBloc signupBloc;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter the OTP sent to your email',
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.signupBloc.add(VerifyOtpButtonClickedEvent(
                    otp: _otpController.text,
                  ));
                },
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
