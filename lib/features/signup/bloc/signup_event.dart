// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupInitialEvent extends SignupEvent {
  
}

class SignUpClickedButtonEvent extends SignupEvent{
final UserSignupModel userModel;
  SignUpClickedButtonEvent({
    required this.userModel,
  });
}




class VerifyOtpButtonClickedEvent extends SignupEvent {
  final String otp;
  VerifyOtpButtonClickedEvent({
    required this.otp,
  });
}
class RedirectLoginPageClickedEvent extends SignupEvent {}


