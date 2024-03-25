import 'dart:async';
import 'dart:developer';
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
    on<SendOtpEvent>(sendOtpEvent);
    on<UploadProfilePhotoClickedEvent>(uploadProfilePhotoClickedEvent);
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
      email: event.otp.email,
      otp: event.otp.otp,
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

  FutureOr<void> sendOtpEvent(
      SendOtpEvent event, Emitter<SignupState> emit) async {
    log('sendOtpEvent');
    emit(OtpSendLoadingState());

    bool sendOTP = await SendOtpRepository.sendOTPToMail(event.emailAddress);

    if (sendOTP) {
      emit(OtpSendSuccessState());
      Fluttertoast.showToast(
          msg: "OTP sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(OtpSendErrorState());
      Fluttertoast.showToast(
          msg: "OTP sending failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  FutureOr<void> uploadProfilePhotoClickedEvent(
      UploadProfilePhotoClickedEvent event, Emitter<SignupState> emit) async {
    emit(UploadProfilePhotoLoadingState());

    bool uploadPhoto = await PhotoUploadRepository.uploadPhoto(event.imagePath);

    if (uploadPhoto) {
      emit(UploadProfilePhotoSuccessState());
      Fluttertoast.showToast(
          msg: "Profile photo uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      emit(UploadProfilePhotoFailureState());
      Fluttertoast.showToast(
          msg: "Profile photo uploading failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
