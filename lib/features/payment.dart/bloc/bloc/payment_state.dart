part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {

  final String message;

  PaymentSuccess({required this.message});
}
class PaymentFailure extends PaymentState {
   final String errorMessage;

  PaymentFailure({required this.errorMessage});
}



