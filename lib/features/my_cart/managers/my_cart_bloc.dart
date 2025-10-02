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
  }

  Future<void> _onLoadMyCart(
      LoadMyCart event, Emitter<MyCartState> emit) async {
    emit(MyCartLoading());
    final result = await repository.getMyCart();
    result.fold(
          (error) => emit(MyCartError(error.toString())),
          (cart) => emit(MyCartLoaded(cart)),
    );
  }

  Future<void> _onAddMyCartProduct(
      AddMyCartProduct event, Emitter<MyCartState> emit) async {
    emit(MyCartLoading());
    final result = await repository.addToMyCart(event.item);
    result.fold(
          (error) => emit(MyCartError(error.toString())),
          (cart) => emit(MyCartLoaded(cart)),
    );
  }

  Future<void> _onRemoveMyCartProduct(
      RemoveMyCartProduct event, Emitter<MyCartState> emit) async {
    emit(MyCartLoading());
    final result = await repository.removeFromMyCart(event.id);
    result.fold(
          (error) => emit(MyCartError(error.toString())),
          (cart) => emit(MyCartLoaded(cart)),
    );
  }
}
