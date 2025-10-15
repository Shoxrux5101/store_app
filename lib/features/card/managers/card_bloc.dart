import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/card_item_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _repository;

  CardBloc({required CardRepository repository})
      : _repository = repository,
        super(CardInitial()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<DeleteCard>(_onDeleteCard);
    on<UpdateCard>(_onUpdateCard);
  }

  Future<void> _onLoadCards(LoadCards event, Emitter<CardState> emit) async {
    emit(CardLoading());
    final result = await _repository.getCards();
    result.fold(
          (error) => emit(CardError(error.toString())),
          (cards) => emit(CardLoaded(cards)),
    );
  }

  Future<void> _onAddCard(AddCard event, Emitter<CardState> emit) async {
    emit(CardAdding());
    final result = await _repository.addCard(
      cardNumber: event.cardNumber,
      expiryDate: event.expiryDate,
      securityCode: event.securityCode,
    );
    result.fold(
          (error) => emit(CardError(error.toString())),
          (card) {
        emit(CardAdded(card));
        add(LoadCards());
      },
    );
  }

  Future<void> _onDeleteCard(DeleteCard event, Emitter<CardState> emit) async {
    emit(CardDeleting());
    final result = await _repository.deleteCard(event.cardId);
    result.fold(
          (error) => emit(CardError(error.toString())),
          (_) {
        emit(CardDeleted());
        add(LoadCards());
      },
    );
  }

  Future<void> _onUpdateCard(UpdateCard event, Emitter<CardState> emit) async {
    emit(CardUpdating());
    final result = await _repository.updateCard(
      cardId: event.cardId,
      cardNumber: event.cardNumber,
      expiryDate: event.expiryDate,
      securityCode: event.securityCode,
    );
    result.fold(
          (error) => emit(CardError(error.toString())),
          (card) {
        emit(CardUpdated(card));
        add(LoadCards());
      },
    );
  }
}
