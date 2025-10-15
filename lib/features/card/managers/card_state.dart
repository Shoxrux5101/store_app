import 'package:equatable/equatable.dart';
import '../../../data/models/card_item_model.dart';

abstract class CardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<CardModel> cards;
  CardLoaded(this.cards);
  @override
  List<Object?> get props => [cards];
}

class CardAdding extends CardState {}

class CardAdded extends CardState {
  final CardModel card;
  CardAdded(this.card);
  @override
  List<Object?> get props => [card];
}

class CardDeleting extends CardState {}

class CardDeleted extends CardState {}

class CardUpdating extends CardState {}

class CardUpdated extends CardState {
  final CardModel card;
  CardUpdated(this.card);
  @override
  List<Object?> get props => [card];
}

class CardError extends CardState {
  final String message;
  CardError(this.message);
  @override
  List<Object?> get props => [message];
}
