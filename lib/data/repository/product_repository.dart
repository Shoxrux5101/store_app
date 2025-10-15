import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<ProductModel>>> getProducts({
    String? title,
    int? categoryId,
    int? sizeId,
    double? minPrice,
    double? maxPrice,
    String? orderBy,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (title != null && title.isNotEmpty) queryParams['Title'] = title;
      if (categoryId != null) queryParams['CategoryId'] = categoryId;
      if (sizeId != null) queryParams['SizeId'] = sizeId;
      if (minPrice != null) queryParams['MinPrice'] = minPrice;
      if (maxPrice != null) queryParams['MaxPrice'] = maxPrice;
      if (orderBy != null && orderBy.isNotEmpty) queryParams['OrderBy'] = orderBy;

      final response = await _apiClient.get('/products/list', queryParams: queryParams);

      return response.fold(
            (error) => Result.error(error),
            (success) {
          final data = (success as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          return Result.ok(data);
        },
      );
    } catch (e) {
      return Result.error(Exception("Failed to fetch products: $e"));
    }
  }

  Future<Result<List<ProductModel>>> getAllProducts() async => getProducts();

  Future<Result<List<ProductModel>>> getProductsByCategory(int categoryId) async =>
      getProducts(categoryId: categoryId);

  Future<Result<List<ProductModel>>> searchProducts(String title) async =>
      getProducts(title: title);

  Future<Result<List<ProductModel>>> getProductsByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async =>
      getProducts(minPrice: minPrice, maxPrice: maxPrice);

  Future<Result<void>> toggleLike(int productId, bool isLiked) async {
    try {
      final response = await _apiClient.post(
        '/products/toggle-like',
        data: {'productId': productId, 'isLiked': isLiked},
      );
      return response.fold(
            (error) => Result.error(error),
            (_) => Result.ok(null),
      );
    } catch (e) {
      return Result.error(Exception("Failed to toggle like: $e"));
    }
  }
}
