import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/my_order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrdersLoaded extends OrderState {
  final List<MyOrderModel> orders;
  final int currentTabIndex;

  const OrdersLoaded({
    required this.orders,
    this.currentTabIndex = 0,
  });

  List<MyOrderModel> get ongoingOrders => orders
      .where((order) {
    final status = order.status.toLowerCase();
    return status == 'packing' ||
        status == 'picked' ||
        status == 'in transit' ||
        status == 'in_transit';
  })
      .toList();

  List<MyOrderModel> get completedOrders => orders
      .where((order) => order.status.toLowerCase() == 'completed')
      .toList();

  OrdersLoaded copyWith({
    List<MyOrderModel>? orders,
    int? currentTabIndex,
  }) {
    return OrdersLoaded(
      orders: orders ?? this.orders,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [orders, currentTabIndex];
}

class OrderDeleting extends OrderState {
  final int orderId;

  const OrderDeleting(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class OrderCreating extends OrderState {
  const OrderCreating();
}

class OrderCreated extends OrderState {
  final int orderId;

  const OrderCreated(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class OrderTrackingLoaded extends OrderState {
  final Map<String, dynamic> tracking;
  final MyOrderModel order;

  const OrderTrackingLoaded({
    required this.tracking,
    required this.order,
  });

  @override
  List<Object?> get props => [tracking, order];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}