part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class MakeMeProMemberEvent extends PaymentEvent {
  final String subscriptionType;

  MakeMeProMemberEvent({required this.subscriptionType});
}
