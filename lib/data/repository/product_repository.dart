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
    Map<String, dynamic> queryParams = {};

    if (title != null && title.isNotEmpty) {
      queryParams['Title'] = title;
    }
    if (categoryId != null) {
      queryParams['CategoryId'] = categoryId;
    }
    if (sizeId != null) {
      queryParams['SizeId'] = sizeId;
    }
    if (minPrice != null) {
      queryParams['MinPrice'] = minPrice;
    }
    if (maxPrice != null) {
      queryParams['MaxPrice'] = maxPrice;
    }
    if (orderBy != null && orderBy.isNotEmpty) {
      queryParams['OrderBy'] = orderBy;
    }
    final response = await _apiClient.get(
      '/products/list',
      queryParams: queryParams,
    );
    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = (success as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.ok(data);
        } catch (e) {
          return Result.error(Exception('Failed to parse products: $e'));
        }
      },
    );
  }
  Future<Result<List<ProductModel>>> getAllProducts() async {
    return getProducts();
  }
  Future<Result<List<ProductModel>>> getProductsByCategory(int categoryId) async {
    return getProducts(categoryId: categoryId);
  }
  Future<Result<List<ProductModel>>> searchProducts(String title) async {
    return getProducts(title: title);
  }
  Future<Result<List<ProductModel>>> getProductsByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    return getProducts(minPrice: minPrice, maxPrice: maxPrice);
  }
}