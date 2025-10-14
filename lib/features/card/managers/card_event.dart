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

  const AddCard(this.cardNumber);

  @override
  List<Object?> get props => [cardNumber];
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

  const UpdateCard({
    required this.cardId,
    required this.cardNumber,
  });

  @override
  List<Object?> get props => [cardId, cardNumber];
}