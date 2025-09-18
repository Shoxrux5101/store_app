import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/product_model.dart';

enum ProductStatus { idle, loading, success, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> products;
  final List<ProductModel> filterProducts;
  final String? errorMassage;
  final int? selectedCategoryId;
  final String? searchQuery;
  final double? maxPrice;
  final double? minPrice;
  final String? sort;

  const ProductState({
    required this.status,
    required this.products,
    required this.filterProducts,
    required this.errorMassage,
    required this.selectedCategoryId,
    required this.searchQuery,
    required this.maxPrice,
    required this.minPrice,
    required this.sort,
  });

  factory ProductState.initial() => ProductState(
    status: ProductStatus.idle,
    products: [],
    filterProducts: [],
    errorMassage: '',
    selectedCategoryId: null,
    searchQuery: '',
    maxPrice: null,
    minPrice: null,
    sort: '',
  );

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? product,
    List<ProductModel>? filterProducts,
    String? errorMassage,
    int? selectedCategoryId,
    String? searchQuery,
    double? maxPrice,
    double? minPrice,
    String? sort,
    bool clearError = false,
    bool clearCategoryId = false,
    bool clearSearch = false,
    bool clearPriceRange = false,
    bool clearSort = false,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      filterProducts: filterProducts ?? this.filterProducts,
      errorMassage: errorMassage ?? this.errorMassage,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    filterProducts,
    errorMassage,
    selectedCategoryId,
    searchQuery,
    maxPrice,
    minPrice,
    sort,
  ];
}
