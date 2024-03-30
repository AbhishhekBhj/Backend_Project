// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginActionState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginActionState {}

class LoginFailureState extends LoginState {}


class ForgotPasswordLoadingState extends LoginState {}
class ForgotPasswordSuccessState extends LoginState {}
class ForgotPasswordFailureState extends LoginState {}