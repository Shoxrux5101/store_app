import 'package:bloc/bloc.dart';
import 'package:store_app/features/home/managers/product_state.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/saved_repository.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/saved_item_model.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  final SavedRepository savedRepository;

  ProductCubit(this.repository, this.savedRepository) : super(ProductState.initial());

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
          (products) async {
        final savedResult = await savedRepository.getSavedItems();
        List<ProductModel> updatedProducts = products;

        savedResult.fold(
              (error) {
          },
              (savedItems) {
            final savedIds = savedItems.map((e) => e.id).toSet();
            updatedProducts = products.map((product) {
              return product.copyWith(isLiked: savedIds.contains(product.id));
            }).toList();
          },
        );

        emit(state.copyWith(
          status: ProductStatus.success,
          products: updatedProducts,
          filterProducts: updatedProducts,
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
          (products) async {
        final savedResult = await savedRepository.getSavedItems();
        List<ProductModel> updatedProducts = products;

        savedResult.fold(
              (error) {},
              (savedItems) {
            final savedIds = savedItems.map((e) => e.id).toSet();
            updatedProducts = products.map((product) {
              return product.copyWith(isLiked: savedIds.contains(product.id));
            }).toList();
          },
        );

        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: updatedProducts,
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
          (products) async {
        final savedResult = await savedRepository.getSavedItems();
        List<ProductModel> updatedProducts = products;

        savedResult.fold(
              (error) {},
              (savedItems) {
            final savedIds = savedItems.map((e) => e.id).toSet();
            updatedProducts = products.map((product) {
              return product.copyWith(isLiked: savedIds.contains(product.id));
            }).toList();
          },
        );

        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: updatedProducts,
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
          (products) async {
        final savedResult = await savedRepository.getSavedItems();
        List<ProductModel> updatedProducts = products;

        savedResult.fold(
              (error) {},
              (savedItems) {
            final savedIds = savedItems.map((e) => e.id).toSet();
            updatedProducts = products.map((product) {
              return product.copyWith(isLiked: savedIds.contains(product.id));
            }).toList();
          },
        );

        emit(state.copyWith(
          status: ProductStatus.success,
          filterProducts: updatedProducts,
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

  Future<void> toggleLike(ProductModel product) async {
    final updatedProducts = state.products.map((p) {
      if (p.id == product.id) {
        return p.copyWith(isLiked: !p.isLiked);
      }
      return p;
    }).toList();

    final updatedFilterProducts = state.filterProducts.map((p) {
      if (p.id == product.id) {
        return p.copyWith(isLiked: !p.isLiked);
      }
      return p;
    }).toList();

    emit(state.copyWith(
      products: updatedProducts,
      filterProducts: updatedFilterProducts,
    ));

    if (!product.isLiked) {
      final savedItem = SavedItem(
        id: product.id,
        categoryId: product.categoryId,
        title: product.title,
        image: product.image,
        price: product.price,
        isLiked: true,
        discount: product.discount,
      );
      await savedRepository.saveItem(savedItem.id);
    } else {
      await savedRepository.unsaveItem(product.id);
    }
  }

  void updateProductsFromSaved(List<SavedItem> savedItems) {
    final savedIds = savedItems.map((e) => e.id).toSet();

    final updatedProducts = state.products.map((product) {
      return product.copyWith(isLiked: savedIds.contains(product.id));
    }).toList();

    final updatedFilterProducts = state.filterProducts.map((product) {
      return product.copyWith(isLiked: savedIds.contains(product.id));
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