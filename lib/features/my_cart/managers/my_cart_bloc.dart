import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/my_cart_repository.dart';
import '../../../data/models/my_cart_model.dart';
import 'my_cart_event.dart';
import 'my_cart_state.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  final MyCartRepository repository;

  MyCartBloc({required this.repository}) : super(MyCartLoading()) {
    on<LoadMyCart>(_onLoadMyCart);
    on<AddMyCartProduct>(_onAddMyCartProduct);
    on<RemoveMyCartProduct>(_onRemoveMyCartProduct);
    on<UpdateMyCartQuantity>(_onUpdateQuantity);
  }

  Future<void> _onLoadMyCart(
      LoadMyCart event,
      Emitter<MyCartState> emit,
      ) async {
    emit(MyCartLoading());
    final result = await repository.getMyCart();

    result.fold(
          (error) => emit(MyCartError(error.toString())),
          (cart) => emit(MyCartLoaded(cart)),
    );
  }

  Future<void> _onAddMyCartProduct(
      AddMyCartProduct event,
      Emitter<MyCartState> emit,
      ) async {
    emit(MyCartLoading());
    final result = await repository.addToMyCart(event.productId, event.sizeId);

    result.fold(
          (error) => emit(MyCartError(error.toString())),
          (cart) => emit(MyCartLoaded(cart)),
    );
  }

  Future<void> _onRemoveMyCartProduct(
      RemoveMyCartProduct event,
      Emitter<MyCartState> emit,
      ) async {
    final currentState = state;
    if (currentState is MyCartLoaded) {
      final oldCart = currentState.cart;

      final result = await repository.removeFromMyCart(event.id);

      result.fold(
            (error) => emit(MyCartLoaded(oldCart)),
            (cart) => emit(MyCartLoaded(cart)),
      );
    }
  }

  Future<void> _onUpdateQuantity(
      UpdateMyCartQuantity event,
      Emitter<MyCartState> emit,
      ) async {
    final currentState = state;
    if (currentState is MyCartLoaded) {
      final oldCart = currentState.cart;

      final updatedItems = oldCart.items.map((item) {
        if (item.id == event.itemId) {
          return MyCartProductItem(
            id: item.id,
            productId: item.productId,
            title: item.title,
            size: item.size,
            price: item.price,
            image: item.image,
            quantity: event.quantity,
          );
        }
        return item;
      }).toList();

      double tempSubTotal = 0;
      for (var item in updatedItems) {
        tempSubTotal += item.price * item.quantity;
      }

      final tempVat = tempSubTotal * 0.15;
      final tempTotal = tempSubTotal + tempVat + oldCart.shippingFee;

      final updatedCart = MyCartItemModel(
        items: updatedItems,
        subTotal: tempSubTotal,
        vat: tempVat,
        shippingFee: oldCart.shippingFee,
        total: tempTotal,
      );

      emit(MyCartLoaded(updatedCart));

      final result = await repository.updateQuantity(
        itemId: event.itemId,
        quantity: event.quantity,
      );

      result.fold(
            (error) => emit(MyCartLoaded(oldCart)),
            (cart) => emit(MyCartLoaded(cart)),
      );
    }
  }
}