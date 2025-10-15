import 'package:equatable/equatable.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/card_item_model.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCheckout extends CheckoutEvent {
  final double subtotal;

  const InitializeCheckout(this.subtotal);

  @override
  List<Object?> get props => [subtotal];
}

class SelectAddress extends CheckoutEvent {
  final Address address;

  const SelectAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class SelectPaymentMethod extends CheckoutEvent {
  final String paymentMethod; // 'card', 'cash', 'apple_pay'

  const SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class SelectCard extends CheckoutEvent {
  final CardModel card;

  const SelectCard(this.card);

  @override
  List<Object?> get props => [card];
}

class ApplyPromoCode extends CheckoutEvent {
  final String promoCode;

  const ApplyPromoCode(this.promoCode);

  @override
  List<Object?> get props => [promoCode];
}

class PlaceOrder extends CheckoutEvent {
  const PlaceOrder();
}
