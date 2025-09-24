import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/card_item_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository repository;

  CardBloc({required this.repository}) : super(CardInitial()) {
    on<LoadCards>(_onLoadCards);
  }

  Future<void> _onLoadCards(
      LoadCards event, Emitter<CardState> emit) async {
    emit(CardLoading());
    final result = await repository.getCards();

    result.fold(
          (error) => emit(CardError(error.toString())),
          (cards) => emit(CardLoaded(cards)),
    );
  }
}
