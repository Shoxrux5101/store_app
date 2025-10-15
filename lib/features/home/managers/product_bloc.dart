import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(const ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
    on<SearchProductsEvent>(_onSearchProducts);
    on<GetProductsByPriceRangeEvent>(_onGetProductsByPriceRange);
    on<SortProductsEvent>(_onSortProducts);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onGetAllProducts(GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await repository.getAllProducts();
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }

  Future<void> _onGetProductsByCategory(GetProductsByCategoryEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await repository.getProductsByCategory(event.categoryId);
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success, categoryId: event.categoryId)),
    );
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await repository.searchProducts(event.title);
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success, title: event.title)),
    );
  }

  Future<void> _onGetProductsByPriceRange(GetProductsByPriceRangeEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await repository.getProductsByPriceRange(minPrice: event.minPrice, maxPrice: event.maxPrice);
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success, minPrice: event.minPrice, maxPrice: event.maxPrice)),
    );
  }

  Future<void> _onSortProducts(SortProductsEvent event, Emitter<ProductState> emit) async {
    final current = state;
    List<ProductModel> products = [];
    int? categoryId;
    String? title;
    double? minPrice;
    double? maxPrice;

    if (current is ProductLoaded) {
      products = List.from(current.products);
      categoryId = current.categoryId;
      title = current.title;
      minPrice = current.minPrice;
      maxPrice = current.maxPrice;
    } else {
      emit(const ProductLoading());
      final res = await repository.getAllProducts();
      var handled = false;
      res.fold(
            (error) => emit(ProductError(error.toString())),
            (success) {
          products = success;
          handled = true;
        },
      );
      if (!handled) return;
    }

    List<ProductModel> sorted = List<ProductModel>.from(products);
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

    emit(ProductLoaded(
      List<ProductModel>.from(sorted),
      sort: event.sortType,
      categoryId: categoryId,
      title: title,
      minPrice: minPrice,
      maxPrice: maxPrice,
    ));
  }

  Future<void> _onClearFilters(ClearFiltersEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await repository.getAllProducts();
    result.fold(
          (error) => emit(ProductError(error.toString())),
          (success) => emit(ProductLoaded(success)),
    );
  }
}
