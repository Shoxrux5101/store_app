import 'package:equatable/equatable.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/card_item_model.dart';
import '../../../data/models/checkout_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutReady extends CheckoutState {
  final Address? selectedAddress;
  final String paymentMethod;
  final CardModel? selectedCard;
  final PromoCodeModel? appliedPromoCode;
  final double subtotal;
  final double vat;
  final double shippingFee;
  final double discount;
  final double total;

  const CheckoutReady({
    this.selectedAddress,
    required this.paymentMethod,
    this.selectedCard,
    this.appliedPromoCode,
    required this.subtotal,
    required this.vat,
    required this.shippingFee,
    required this.discount,
    required this.total,
  });

  @override
  List<Object?> get props => [
    selectedAddress,
    paymentMethod,
    selectedCard,
    appliedPromoCode,
    subtotal,
    vat,
    shippingFee,
    discount,
    total,
  ];

  CheckoutReady copyWith({
    Address? selectedAddress,
    String? paymentMethod,
    CardModel? selectedCard,
    PromoCodeModel? appliedPromoCode,
    double? subtotal,
    double? vat,
    double? shippingFee,
    double? discount,
    double? total,
    bool clearCard = false,
    bool clearPromo = false,
  }) {
    return CheckoutReady(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectedCard: clearCard ? null : (selectedCard ?? this.selectedCard),
      appliedPromoCode: clearPromo ? null : (appliedPromoCode ?? this.appliedPromoCode),
      subtotal: subtotal ?? this.subtotal,
      vat: vat ?? this.vat,
      shippingFee: shippingFee ?? this.shippingFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
    );
  }
}

class PromoCodeApplying extends CheckoutState {}

class OrderPlacing extends CheckoutState {}

class OrderPlaced extends CheckoutState {
  final int orderId;

  const OrderPlaced(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}
