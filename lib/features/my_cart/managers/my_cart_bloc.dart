import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/my_cart_repository.dart';
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

      // 1. UI’da darhol yangilash
      final updatedItems = oldCart.items.map((item) {
        if (item.id == event.itemId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();

      final tempSubTotal = updatedItems.fold<double>(
        0,
            (sum, item) => sum + item.price * item.quantity,
      );
      final tempVat = tempSubTotal * 0.15;
      final tempTotal = tempSubTotal + tempVat + oldCart.shippingFee;

      final updatedCart = oldCart.copyWith(
        items: updatedItems,
        subTotal: tempSubTotal,
        vat: tempVat,
        total: tempTotal,
      );

      emit(MyCartLoaded(updatedCart));

      // 2. API update qilish
      final result = await repository.updateQuantity(
        itemId: event.itemId,
        quantity: event.quantity,
      );

      // 3. Agar API xatolik bo‘lsa, eski holatga qaytarish
      result.fold(
            (error) {
          emit(MyCartLoaded(oldCart));
        },
            (_) {
          // Agar kerak bo‘lsa API’dan kelgan yangi cart data bilan update qilamiz
        },
      );
    }
  }

}