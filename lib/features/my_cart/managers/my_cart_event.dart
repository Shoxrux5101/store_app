import '../../../data/models/my_cart_model.dart';

abstract class MyCartEvent {}

class LoadMyCart extends MyCartEvent {}

class AddMyCartProduct extends MyCartEvent {
  final MyCartProductItem item;
  AddMyCartProduct(this.item);
}

class RemoveMyCartProduct extends MyCartEvent {
  final int id;
  RemoveMyCartProduct(this.id);
}
