import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/login_model.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';
import 'package:mygymbuddy/features/login/bloc/login_bloc.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

import '../forgot_password.dart';
import '../loader/custom_loader.dart';
import '../signup_page.dart';

class DemoLoginPage extends StatefulWidget {
  const DemoLoginPage({super.key});

  @override
  State<DemoLoginPage> createState() => _DemoLoginPageState();
}

class _DemoLoginPageState extends State<DemoLoginPage> {
  LoginBloc loginBloc = LoginBloc();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Image.asset(splashIcon),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.blue,
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        TextFormField(
                          cursorColor: Colors.blue,
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: 'Password',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            border: const UnderlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        loginBloc.add(LoginButtonClickedEvent(
                            loginModel: LoginModel(
                                username: usernameController.text,
                                password: passwordController.text)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0DA0FF),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.25, vertical: 20),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(ForgotPasswordScreen());
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ))),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        Get.to(BaseClass());
                      }
                    },
                    bloc: loginBloc,
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const CustomLoader();
                      }
                      return Container();
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(SignupPage());
                      },
                      child: Text("Or Sign Up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
