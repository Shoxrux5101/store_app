import '../../../data/models/my_cart_model.dart';

abstract class MyCartState {}

class MyCartLoading extends MyCartState {}

class MyCartLoaded extends MyCartState {
  final MyCartItemModel cart;
  MyCartLoaded(this.cart);
}

class MyCartError extends MyCartState {
  final String message;
  MyCartError(this.message);
}
