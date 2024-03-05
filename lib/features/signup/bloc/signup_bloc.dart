import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    on<VerifyOtpButtonClickedEvent>(verifyOtpButtonClickedEvent);
  }

  FutureOr<void> signupInitialEvent(
      SignupInitialEvent event, Emitter<SignupState> emit) async {
    emit(SignupInitial());
  }

  FutureOr<void> signUpClickedButtonEvent(
      SignUpClickedButtonEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());

    // bool signup = await SignupRepository.signupUser();
    bool signup = await SignupRepository.signupUser(UserSignupModel(
      age: event.userModel.age,
      email: event.userModel.email,
      fitnessGoal: event.userModel.fitnessGoal,
      fitnessLevel: event.userModel.fitnessLevel,
      height: event.userModel.height,
      name: event.userModel.name,
      password: event.userModel.password,
      weight: event.userModel.weight,
      username: event.userModel.username,
    ));

    if (signup == true) {
      print('acv');
      emit(SignupSuccessState());
      Fluttertoast.showToast(
          msg: "Signup successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(SignupErrorState());
      Fluttertoast.showToast(
          msg: "Signup failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  FutureOr<void> redirectLoginPageClickedEvent(
      RedirectLoginPageClickedEvent event, Emitter<SignupState> emit) {
    emit(SignupNavigationState());
  }

  FutureOr<void> verifyOtpButtonClickedEvent(
      VerifyOtpButtonClickedEvent event, Emitter<SignupState> emit) async {
    emit(VerifyOtpLoadingState());
    bool otp = await VerifyOtpRepository.verifyOtp(OTPModel(
      email: event.otp,
      otp: event.otp,
    ));

    if (otp == true) {
      emit(VerifyOtpSuccessState());
      Fluttertoast.showToast(
          msg: "OTP verified successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(VerifyOtpErrorState());
      Fluttertoast.showToast(
          msg: "OTP verification failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
