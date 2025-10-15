import 'package:equatable/equatable.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

class LoadCards extends CardEvent {
  const LoadCards();
}

class AddCard extends CardEvent {
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  const AddCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });

  @override
  List<Object?> get props => [cardNumber, expiryDate, securityCode];
}

class DeleteCard extends CardEvent {
  final int cardId;

  const DeleteCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class UpdateCard extends CardEvent {
  final int cardId;
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  const UpdateCard({
    required this.cardId,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });

  @override
  List<Object?> get props => [cardId, cardNumber, expiryDate, securityCode];
}