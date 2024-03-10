part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

// indicates form is ready
abstract class SignupActionState extends SignupState {}

final class SignupInitial extends SignupState {}

//signup process in progress
class SignupLoadingState extends SignupState {}

//successful signup
class SignupSuccessState extends SignupActionState {}

//some error occured during signup
class SignupErrorState extends SignupState {}

class SignupNavigationState extends SignupActionState {}


//states for verifying otp
class VerifyOtpSuccessState extends SignupActionState {}

class VerifyOtpErrorState extends SignupState {}

class VerifyOtpLoadingState extends SignupState {}


//states for sending otp
class OtpSendLoadingState extends SignupState {}

class OtpSendSuccessState extends SignupActionState {}

class OtpSendErrorState extends SignupState {}



//states for uploading profile photo

class UploadProfilePhotoLoadingState extends SignupState {}
class UploadProfilePhotoFailureState extends SignupState {}
class UploadProfilePhotoSuccessState extends SignupActionState {}

