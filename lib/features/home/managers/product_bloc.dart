import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
    on<SearchProductsEvent>(_onSearchProducts);
    on<GetProductsByPriceRangeEvent>(_onGetProductsByPriceRange);
    on<SortProductsEvent>(_onSortProducts);
    on<ClearFiltersEvent>(_onClearFilters);
    on<ToggleLikeEvent>(_onToggleLike);
  }

  Future<void> _onGetAllProducts(GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await repository.getAllProducts();
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onGetProductsByCategory(GetProductsByCategoryEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await repository.getProductsByCategory(event.categoryId);
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await repository.searchProducts(event.title);
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onGetProductsByPriceRange(GetProductsByPriceRangeEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await repository.getProductsByPriceRange(
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    );
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onSortProducts(SortProductsEvent event, Emitter<ProductState> emit) async {
    final current = state;
    if (current is ProductLoaded) {
      List<ProductModel> sorted = List.from(current.products);
      switch (event.sortType) {
        case 'price_low_high':
          sorted.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_high_low':
          sorted.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'name_a_z':
          sorted.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
          break;
        case 'name_z_a':
          sorted.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
          break;
        case 'discount':
          sorted.sort((a, b) => b.discount.compareTo(a.discount));
          break;
      }
      emit(current.copyWith(products: sorted));
    }
  }

  Future<void> _onClearFilters(ClearFiltersEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await repository.getAllProducts();
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onToggleLike(ToggleLikeEvent event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(isLiked: event.isLiked);
        }
        return product;
      }).toList();
      emit(currentState.copyWith(products: updatedProducts));
      await repository.toggleLike(event.productId, event.isLiked);
    }
  }
}
