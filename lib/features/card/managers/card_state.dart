import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/card_item_model.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class CardLoaded extends CardState {
  final List<CardModel> cards;

  const CardLoaded(this.cards);

  @override
  List<Object?> get props => [cards];
}

final class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object?> get props => [message];
}
