import 'package:equatable/equatable.dart';
import '../../../data/models/card_item_model.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

class CardInitial extends CardState {
  const CardInitial();
}

class CardLoading extends CardState {
  const CardLoading();
}

class CardLoaded extends CardState {
  final List<CardModel> cards;

  const CardLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

class CardAdding extends CardState {
  const CardAdding();
}

class CardAdded extends CardState {
  final CardModel card;

  const CardAdded(this.card);

  @override
  List<Object?> get props => [card];
}

class CardDeleting extends CardState {
  const CardDeleting();
}

class CardDeleted extends CardState {
  const CardDeleted();
}

class CardUpdating extends CardState {
  const CardUpdating();
}

class CardUpdated extends CardState {
  final CardModel card;

  const CardUpdated(this.card);

  @override
  List<Object?> get props => [card];
}

class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object?> get props => [message];
}