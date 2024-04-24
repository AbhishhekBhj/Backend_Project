import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/login_model.dart';
import 'package:mygymbuddy/features/repo/login%20repo/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    });
  }

 
  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    final bool loginUserSuccess = await LoginRepository.loginUser(
        username: event.loginModel.username,
        password: event.loginModel.password);
    if (loginUserSuccess) {
      emit(LoginSuccessState());
    } else {
      Fluttertoast.showToast(
          msg: "Invalid username or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginFailureState());
    }
  }
}
