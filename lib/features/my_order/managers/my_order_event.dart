import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrdersEvent extends OrderEvent {
  const LoadOrdersEvent();
}

class ChangeOrderTabEvent extends OrderEvent {
  final int tabIndex;
  const ChangeOrderTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class DeleteOrderEvent extends OrderEvent {
  final int orderId;

  const DeleteOrderEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CreateOrderEvent extends OrderEvent {
  final int addressId;
  final String paymentMethod;
  final int? cardId;
  final String? promoCode;

  const CreateOrderEvent({
    required this.addressId,
    required this.paymentMethod,
    this.cardId,
    this.promoCode,
  });

  @override
  List<Object?> get props => [addressId, paymentMethod, cardId, promoCode];
}

class LoadOrderTrackingEvent extends OrderEvent {
  final int orderId;

  const LoadOrderTrackingEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}