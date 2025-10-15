import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/my_order_model.dart';
import 'package:store_app/data/repository/my_order_repository.dart';

import '../../../data/models/star_model.dart';
import 'my_order_event.dart';
import 'my_order_state.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final MyOrderRepository repository;

  OrderBloc({required this.repository}) : super(const OrderInitial()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<ChangeOrderTabEvent>(_onChangeTab);
    on<DeleteOrderEvent>(_onDeleteOrder);
    on<CreateOrderEvent>(_onCreateOrder);
    on<LoadOrderTrackingEvent>(_onLoadTracking);
    on<UpdateOrderReviewEvent>(_onUpdateReview);
  }

  Future<void> _onLoadOrders(
      LoadOrdersEvent event, Emitter<OrderState> emit) async {
    emit(const OrderLoading());
    final result = await repository.getOrders();

    result.fold(
          (error) => emit(OrderError(error.toString())),
          (orders) => emit(OrdersLoaded(orders: orders)),
    );
  }

  void _onChangeTab(ChangeOrderTabEvent event, Emitter<OrderState> emit) {
    if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      emit(currentState.copyWith(currentTabIndex: event.tabIndex));
    }
  }

  Future<void> _onDeleteOrder(
      DeleteOrderEvent event, Emitter<OrderState> emit) async {
    if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      emit(OrderDeleting(event.orderId));

      final result = await repository.deleteOrder(event.orderId);
      result.fold(
            (error) {
          emit(OrderError(error.toString()));
          emit(currentState); // rollback
        },
            (_) {
          final updatedOrders = currentState.orders
              .where((order) => order.id != event.orderId)
              .toList();
          emit(currentState.copyWith(orders: updatedOrders));
        },
      );
    }
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(const OrderCreating());

    final result = await repository.createOrder(
      addressId: event.addressId,
      paymentMethod: event.paymentMethod,
      cardId: event.cardId,
      promoCode: event.promoCode,
    );

    result.fold(
          (error) => emit(OrderError(error.toString())),
          (orderId) async {
        final ordersResult = await repository.getOrders();
        ordersResult.fold(
              (err) => emit(OrderError(err.toString())),
              (orders) => emit(OrdersLoaded(orders: orders)),
        );
      },
    );
  }

  Future<void> _onLoadTracking(
      LoadOrderTrackingEvent event, Emitter<OrderState> emit) async {
    if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      final order = currentState.orders.firstWhere(
            (o) => o.id == event.orderId,
      );

      emit(const OrderLoading());

      final result = await repository.getOrderTracking(event.orderId);
      result.fold(
            (error) {
          emit(OrderError(error.toString()));
          emit(currentState);
        },
            (tracking) => emit(OrderTrackingLoaded(
          tracking: tracking,
          order: order,
        )),
      );
    }
  }

  Future<void> _onUpdateReview(
      UpdateOrderReviewEvent event, Emitter<OrderState> emit) async {
    if (state is OrdersLoaded) {
      final currentState = state as OrdersLoaded;
      final updatedOrders = currentState.orders.map((order) {
        if (order.id == event.orderId) {
          return MyOrderModel(
            id: order.id,
            title: order.title,
            image: order.image,
            productId: order.productId,
            size: order.size,
            price: order.price,
            status: order.status,
            rating: event.review.rating,
            orderNumber: order.orderNumber,
          );
        }
        return order;
      }).toList();

      emit(currentState.copyWith(orders: updatedOrders));
    }
  }
}

class UpdateOrderReviewEvent extends OrderEvent {
  final int orderId;
  final StarModel review;

  const UpdateOrderReviewEvent(this.orderId, this.review);
}