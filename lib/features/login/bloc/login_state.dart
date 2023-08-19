import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

// Initial state when the screen loads
class LoginInitial extends LoginState {}

// State to indicate that the login request is in progress
class LoginLoadingState extends LoginState {}

// State to indicate that the login was successful
class LoginSuccessState extends LoginState {}

// State to indicate that the login failed
class LoginFailureState extends LoginState {
  // You can include more details about the failure here if needed
}

// State to navigate to the signup page
class SignupNavigationState extends LoginState {}

// State to indicate successful logout
class LogoutSuccessState extends LoginState {}

// State to indicate that logout failed
class LogoutFailureState extends LoginState {
  // You can include more details about the failure here if needed
}
