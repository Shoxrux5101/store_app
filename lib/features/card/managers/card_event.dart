import 'package:equatable/equatable.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCards extends CardEvent {
  const LoadCards();
}
