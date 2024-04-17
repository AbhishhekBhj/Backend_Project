import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/profile/bloc/bloc/profile_bloc.dart';

import '../../signup/ui/welcome_screen.dart/logins.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => PasswordChangeState();
}

class PasswordChangeState extends State<PasswordChange> {
  late ProfileBloc _profileBloc;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your new password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    helperText: "New Password", labelText: "New Password"),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _profileBloc.add(ChangePasswordClickedEvent(
                      _newPasswordController.text,
                    ));
                  }
                },
                child: Text("Change Password"),
              ),
              BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is PasswordChangeSuccessState) {
                    Get.offAll(DemoLoginPage());
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is PasswordChangeLoadingState) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
