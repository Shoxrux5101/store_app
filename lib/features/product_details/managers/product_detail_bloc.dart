import 'package:bloc/bloc.dart';
import 'package:store_app/features/product_details/managers/product_detail_even.dart';
import 'package:store_app/features/product_details/managers/product_detail_state.dart';

import '../../../data/repository/product_detail_repository.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository repository;

  ProductDetailBloc({required this.repository})
      : super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<ToggleLikeDetailEvent>(_onToggleLike);
  }

  Future<void> _onLoadProductDetail(
      LoadProductDetail event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    final result = await repository.getProductDetail(event.id);
    result.fold(
          (error) => emit(ProductDetailError(error.toString())),
          (product) => emit(ProductDetailLoaded(product)),
    );
  }

  Future<void> _onToggleLike(
      ToggleLikeDetailEvent event, Emitter<ProductDetailState> emit) async {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;

      final updatedProduct = currentState.product.copyWith(
        isLiked: event.isLiked,
      );
      emit(ProductDetailLoaded(updatedProduct));
      await repository.toggleLike(event.productId, event.isLiked);
    }
  }
}