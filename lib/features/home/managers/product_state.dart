import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel>? filteredProducts;
  final String? sort;
  final int? categoryId;
  final String? title;
  final double? minPrice;
  final double? maxPrice;

  const ProductLoaded(
      this.products, {
        this.filteredProducts,
        this.sort,
        this.categoryId,
        this.title,
        this.minPrice,
        this.maxPrice,
      });

  ProductLoaded copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? sort,
    int? categoryId,
    String? title,
    double? minPrice,
    double? maxPrice,
  }) {
    return ProductLoaded(
      products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      sort: sort ?? this.sort,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props =>
      [products, filteredProducts, sort, categoryId, title, minPrice, maxPrice];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  String get error => message;
  String get errorMassage => message;

  @override
  List<Object?> get props => [message];
}
