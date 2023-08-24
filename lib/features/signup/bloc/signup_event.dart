// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupInitialEvent extends SignupEvent {
  
}

class SignUpClickedButtonEvent extends SignupEvent{
final UserModel userModel;
  SignUpClickedButtonEvent({
    required this.userModel,
  });
}

class RedirectLoginPageClickedEvent extends SignupEvent {}


