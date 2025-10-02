import 'package:bloc/bloc.dart';
import 'package:store_app/features/home/managers/product_state.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/models/product_model.dart';


class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductState.initial());

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await repository.getAllProducts();

    result.fold(
          (error) {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMassage: error.toString(),
        ));
      },
          (products) {
        emit(state.copyWith(
          status: ProductStatus.success,
          products: products,
          filterProducts: products,
          clearError: true,
        ));
      },
    );
  }

  Future<void> filterByCategory(int? categoryId) async {
    if (categoryId == null || categoryId == -1) {
      emit(state.copyWith(
        status: ProductStatus.success,
        filterProducts: state.products,
        clearCategoryId: true,
        clearError: true,
      ));
      return;
    }

    emit(state.copyWith(status: ProductStatus.loading));

    final result = await repository.getProductsByCategory(categoryId);

    result.fold(
          (error) {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMassage: error.toString(),
        ));
      },
          (products) {
        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: products,
          selectedCategoryId: categoryId,
          clearError: true,
        ));
      },
    );
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
        filterProducts: state.products,
        clearSearch: true,
      ));
      return;
    }

    emit(state.copyWith(status: ProductStatus.loading));

    final result = await repository.searchProducts(query);

    result.fold(
          (error) {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMassage: error.toString(),
        ));
      },
          (products) {
        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: products,
          searchQuery: query,
          clearError: true,
        ));
      },
    );
  }

  Future<void> filterByPriceRange(double minPrice, double maxPrice) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await repository.getProductsByPriceRange(
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    result.fold(
          (error) {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMassage: error.toString(),
        ));
      },
          (products) {
        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: products,
          minPrice: minPrice,
          maxPrice: maxPrice,
          clearError: true,
        ));
      },
    );
  }

  void sortProducts(String sortBy) {
    List<ProductModel> sortedProducts = List.from(state.filterProducts);

    switch (sortBy.toLowerCase()) {
      case 'price_low_high':
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high_low':
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'name_a_z':
        sortedProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'name_z_a':
        sortedProducts.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'discount':
        sortedProducts.sort((a, b) => b.discount.compareTo(a.discount));
        break;
      default:
        break;
    }

    emit(state.copyWith(
      filterProducts: sortedProducts,
      sort: sortBy,
    ));
  }

  void toggleLike(int productId) {
    final updatedProducts = state.products.map((product) {
      if (product.id == productId) {
        return product.copyWith(isLiked: !product.isLiked);
      }
      return product;
    }).toList();

    final updatedFilterProducts = state.filterProducts.map((product) {
      if (product.id == productId) {
        return product.copyWith(isLiked: !product.isLiked);
      }
      return product;
    }).toList();

    emit(state.copyWith(
      products: updatedProducts,
      filterProducts: updatedFilterProducts,
    ));
  }

  void clearFilters() {
    emit(state.copyWith(
      filterProducts: state.products,
      clearCategoryId: true,
      clearSearch: true,
      clearPriceRange: true,
      clearSort: true,
    ));
  }

  void reset() {
    emit(ProductState.initial());
  }
}