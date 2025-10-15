import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class GetAllProductsEvent extends ProductEvent {
  const GetAllProductsEvent();
}

class GetProductsByCategoryEvent extends ProductEvent {
  final int categoryId;
  const GetProductsByCategoryEvent(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}

class SearchProductsEvent extends ProductEvent {
  final String title;
  const SearchProductsEvent(this.title);
  @override
  List<Object?> get props => [title];
}
class GetProductsByPriceRangeEvent extends ProductEvent {
  final double minPrice;
  final double maxPrice;
  const GetProductsByPriceRangeEvent(this.minPrice, this.maxPrice);
  @override
  List<Object?> get props => [minPrice, maxPrice];
}

class SortProductsEvent extends ProductEvent {
  final String sortType;
  const SortProductsEvent(this.sortType);
  @override
  List<Object?> get props => [sortType];
}

class ClearFiltersEvent extends ProductEvent {
  const ClearFiltersEvent();
}

class ToggleLikeEvent extends ProductEvent {
  final int productId;
  final bool isLiked;
  const ToggleLikeEvent(this.productId, this.isLiked);
  @override
  List<Object?> get props => [productId, isLiked];
}
