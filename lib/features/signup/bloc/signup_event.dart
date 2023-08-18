// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupFormSubmittedEvent extends SignupEvent {
  final UserModel userModel;
  SignupFormSubmittedEvent({
    required this.userModel,
  });
}

class RedirectLoginPageClickedEvent extends SignupEvent {}

class SignupFormUpdatedEvent extends SignupEvent {}

class NavigateToLoginEvent extends SignupEvent{}