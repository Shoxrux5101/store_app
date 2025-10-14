import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/card_item_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _repository;

  CardBloc({required CardRepository repository})
      : _repository = repository,
        super(const CardInitial()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<DeleteCard>(_onDeleteCard);
    on<UpdateCard>(_onUpdateCard);
  }

  Future<void> _onLoadCards(
      LoadCards event,
      Emitter<CardState> emit,
      ) async {
    emit(const CardLoading());

    final result = await _repository.getCards();

    result.fold(
          (error) => emit(CardError(error.toString())),
          (cards) => emit(CardLoaded(cards)),
    );
  }

  Future<void> _onAddCard(
      AddCard event,
      Emitter<CardState> emit,
      ) async {
    emit(const CardAdding());

    final result = await _repository.addCard(event.cardNumber);

    result.fold(
          (error) => emit(CardError(error.toString())),
          (card) {
        emit(CardAdded(card));
        add(const LoadCards());
      },
    );
  }

  Future<void> _onDeleteCard(
      DeleteCard event,
      Emitter<CardState> emit,
      ) async {
    emit(const CardDeleting());

    final result = await _repository.deleteCard(event.cardId);

    result.fold(
          (error) => emit(CardError(error.toString())),
          (_) {
        emit(const CardDeleted());
        add(const LoadCards());
      },
    );
  }

  Future<void> _onUpdateCard(
      UpdateCard event,
      Emitter<CardState> emit,
      ) async {
    emit(const CardUpdating());

    final result = await _repository.updateCard(
      event.cardId,
      event.cardNumber,
    );

    result.fold(
          (error) => emit(CardError(error.toString())),
          (card) {
        emit(CardUpdated(card));
        add(const LoadCards());
      },
    );
  }
}