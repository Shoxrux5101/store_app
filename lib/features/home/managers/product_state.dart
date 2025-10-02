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
    this.errorMassage,
    this.selectedCategoryId,
    this.searchQuery,
    this.maxPrice,
    this.minPrice,
    this.sort,
  });

  factory ProductState.initial() => const ProductState(
    status: ProductStatus.idle,
    products: [],
    filterProducts: [],
    errorMassage: null,
    selectedCategoryId: null,
    searchQuery: null,
    maxPrice: null,
    minPrice: null,
    sort: null,
  );

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
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
      errorMassage: clearError ? null : errorMassage ?? this.errorMassage,
      selectedCategoryId: clearCategoryId ? null : selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: clearSearch ? null : searchQuery ?? this.searchQuery,
      maxPrice: clearPriceRange ? null : maxPrice ?? this.maxPrice,
      minPrice: clearPriceRange ? null : minPrice ?? this.minPrice,
      sort: clearSort ? null : sort ?? this.sort,
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