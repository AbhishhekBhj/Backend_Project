import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mygymbuddy/data/models/signup_model.dart';
import 'package:mygymbuddy/features/repo/signup%20repo/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupInitialEvent>(signupInitialEvent);
    on<SignUpClickedButtonEvent>(signUpClickedButtonEvent);
    on<RedirectLoginPageClickedEvent>(redirectLoginPageClickedEvent);
  }

  FutureOr<void> signupInitialEvent(
      SignupInitialEvent event, Emitter<SignupState> emit) async {
    emit(SignupInitial());
  }

  FutureOr<void> signUpClickedButtonEvent(
      SignUpClickedButtonEvent event, Emitter<SignupState> emit) async {
    emit(
        SignupLoadingState()); // bool signup = await SignupRepository.signupUser();
    bool signup = await SignupRepository.signupUser(
        username: event.userModel.username,
        name: event.userModel.name,
        email: event.userModel.email,
        image: event.userModel.image,
        password: event.userModel.password,
        age: event.userModel.age);
    print(signup);

    if (signup == true) {
      print('acv');
      emit(SignupSuccessState());
    } else {
      emit(SignupErrorState());
    }
  }

  FutureOr<void> redirectLoginPageClickedEvent(
      RedirectLoginPageClickedEvent event, Emitter<SignupState> emit) {
    emit(SignupNavigationState());
  }
}
