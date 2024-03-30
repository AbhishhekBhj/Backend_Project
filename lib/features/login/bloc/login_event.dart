// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final LoginModel loginModel;
  LoginButtonClickedEvent({
    required this.loginModel,
  });
}


class ForgotPasswordButtonClickedEvent extends LoginEvent {
  final String email;
  ForgotPasswordButtonClickedEvent({
    required this.email,
  });
}