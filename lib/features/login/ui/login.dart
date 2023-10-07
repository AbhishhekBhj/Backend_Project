import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/data/models/login_model.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';
import 'package:mygymbuddy/features/login/bloc/login_bloc.dart';
import 'package:mygymbuddy/features/login/ui/login_form_widget.dart';
import 'package:mygymbuddy/features/signup/ui/welcome_widget.dart';
import 'package:mygymbuddy/texts/texts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginBloc loginBloc = LoginBloc();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listenWhen: (previous, current) => current is LoginActionState,
        buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Get.to(BaseClass());
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginLoadingState:
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );

            case LoginInitial:
              return (Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    UpperWelcome(textTheme: textTheme),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    LowerWelcome(
                      textTheme: textTheme,
                      subTitle: welcome,
                    ),
                    LoginForm(
                        usernameController: usernameController,
                        passwordController: passwordController,
                        usernameLabel: usernameLabel,
                        passwordLabel: passwordLabel,
                        usernameHintText: usernameHintText,
                        passwordHintText: passwordHintText),
                    FloatingActionButton(
                      onPressed: () {
                        loginBloc.add(LoginButtonClickedEvent(
                            loginModel: LoginModel(
                                username: usernameController.text,
                                password: passwordController.text)));
                      },
                      child: Text(login),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                  ],
                ),
              ));

            case LoginFailureState:
              return Container(
                child: Center(
                  child: Text(
                    "error",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
          }
          return SizedBox();
        },
      ),
    );
  }
}
