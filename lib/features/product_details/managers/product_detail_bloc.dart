import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/product_detail_repository.dart';
import 'product_detail_even.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository repository;

  ProductDetailBloc({required this.repository})
      : super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
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
}
