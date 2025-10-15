import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/checkout_model.dart';
import '../../../data/repository/checkout_repository.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository _repository;

  CheckoutBloc({required CheckoutRepository repository})
      : _repository = repository,
        super(CheckoutInitial()) {
    on<InitializeCheckout>(_onInitializeCheckout);
    on<SelectAddress>(_onSelectAddress);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<SelectCard>(_onSelectCard);
    on<ApplyPromoCode>(_onApplyPromoCode);
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onInitializeCheckout(
      InitializeCheckout event,
      Emitter<CheckoutState> emit,
      ) async {
    emit(CheckoutLoading());
    emit(CheckoutReady(
      paymentMethod: 'card',
      subtotal: event.subtotal,
      vat: 0.0,
      shippingFee: 80.0,
      discount: 0.0,
      total: event.subtotal + 80.0,
    ));
  }

  Future<void> _onSelectAddress(
      SelectAddress event,
      Emitter<CheckoutState> emit,
      ) async {
    final currentState = state;
    if (currentState is CheckoutReady) {
      print('Address selected: ${event.address.nickname}');
      emit(currentState.copyWith(selectedAddress: event.address));
    }
  }

  Future<void> _onSelectPaymentMethod(
      SelectPaymentMethod event,
      Emitter<CheckoutState> emit,
      ) async {
    final currentState = state;
    if (currentState is CheckoutReady) {
      print('Payment method selected: ${event.paymentMethod}');
      emit(currentState.copyWith(
        paymentMethod: event.paymentMethod,
        clearCard: event.paymentMethod != 'card',
      ));
    }
  }

  Future<void> _onSelectCard(
      SelectCard event,
      Emitter<CheckoutState> emit,
      ) async {
    final currentState = state;
    if (currentState is CheckoutReady) {
      print('Card selected: ${event.card.cardNumber}');
      emit(currentState.copyWith(selectedCard: event.card));
    }
  }

  Future<void> _onApplyPromoCode(
      ApplyPromoCode event,
      Emitter<CheckoutState> emit,
      ) async {
    final currentState = state;
    if (currentState is CheckoutReady) {
      emit(PromoCodeApplying());

      final result = await _repository.validatePromoCode(event.promoCode);

      result.fold(
            (error) {
          emit(CheckoutError(error.toString()));
          emit(currentState);
        },
            (promoCode) {
          double discount = 0.0;
          if (promoCode.type == 'percentage') {
            discount = currentState.subtotal * (promoCode.discount / 100);
          } else {
            discount = promoCode.discount;
          }

          final newTotal = currentState.subtotal +
              currentState.vat +
              currentState.shippingFee -
              discount;

          emit(currentState.copyWith(
            appliedPromoCode: promoCode,
            discount: discount,
            total: newTotal,
          ));
        },
      );
    }
  }

  Future<void> _onPlaceOrder(
      PlaceOrder event,
      Emitter<CheckoutState> emit,
      ) async {
    final currentState = state;
    if (currentState is CheckoutReady) {
      // Debug prints
      print('Current state address: ${currentState.selectedAddress}');
      print('Current state card: ${currentState.selectedCard}');
      print('Payment method: ${currentState.paymentMethod}');

      if (currentState.selectedAddress == null) {
        print('Error: No address selected');
        emit(const CheckoutError('Please select a delivery address'));
        emit(currentState);
        return;
      }

      if (currentState.paymentMethod == 'card' &&
          currentState.selectedCard == null) {
        print('Error: No card selected');
        emit(const CheckoutError('Please select a payment card'));
        emit(currentState);
        return;
      }

      emit(OrderPlacing());

      final order = OrderModel(
        subtotal: currentState.subtotal,
        vat: currentState.vat,
        shippingFee: currentState.shippingFee,
        total: currentState.total,
        addressId: currentState.selectedAddress!.id!,
        cardId: currentState.selectedCard?.id,
        paymentMethod: currentState.paymentMethod,
        promoCode: currentState.appliedPromoCode?.code,
      );

      final result = await _repository.createOrder(order);

      result.fold(
            (error) {
          print('Order creation error: $error');
          emit(CheckoutError(error.toString()));
          emit(currentState);
        },
            (createdOrder) {
          print('Order created successfully: ${createdOrder.id}');
          emit(OrderPlaced(createdOrder.id!));
        },
      );
    }
  }
}