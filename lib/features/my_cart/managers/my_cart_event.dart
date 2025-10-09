import '../../../data/models/my_cart_model.dart';

abstract class MyCartEvent {}

class LoadMyCart extends MyCartEvent {}

class AddMyCartProduct extends MyCartEvent {
  // final MyCartProductItem item;
  final int productId;
  final int sizeId;
  AddMyCartProduct(this.productId, this.sizeId);

}

class RemoveMyCartProduct extends MyCartEvent {
  final int id;
  RemoveMyCartProduct(this.id);
}
class UpdateMyCartQuantity extends MyCartEvent {
  final int itemId;
  final int quantity;

  UpdateMyCartQuantity({
    required this.itemId,
    required this.quantity,
  });
}