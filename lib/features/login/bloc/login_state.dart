part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {}

class SignupNavigationState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LogoutFailureState extends LoginState {}
