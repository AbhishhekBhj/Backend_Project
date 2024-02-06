import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/profile/bloc/bloc/profile_bloc.dart';
import 'package:mygymbuddy/features/profile/ui/password_change.dart';
import 'package:mygymbuddy/features/repo/profile%20repo/profile_repository.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  late ProfileBloc _profileBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  bool correctPassword = false;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('First Enter your old password'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _oldPasswordController,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(),
                        border: UnderlineInputBorder(),
                        labelText: 'Old Password',
                      ),
                    ),
                    const SizedBox(height: 50),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          log(_oldPasswordController.text);
                          _profileBloc.add(CheckPasswordClickEvent(
                              _oldPasswordController.text));
                        },
                        child: const Text('Check Password'),
                      );
                    }),
                    BlocListener<ProfileBloc, ProfileState>(
                      bloc: _profileBloc,
                      listener: (context, state) {


                       
                        if (state is PasswordCheckSuccessState) {
                          log(state.toString());

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => ProfileBloc(),
                                    child: PasswordChange(),
                                  )));

                          // Get.to(BlocProvider(
                          //   create: (context) => ProfileBloc(),
                          //   child: PasswordChange(),
                          // ));
                        }
                      },
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
