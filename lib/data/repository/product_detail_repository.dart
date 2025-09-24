import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import 'package:store_app/data/models/product_detail_model.dart';

class ProductDetailRepository {
  final ApiClient _apiClient;

  ProductDetailRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<Result<ProductDetailModel>> getProductDetail(int id) async {
    final response = await _apiClient.get('/products/detail/$id');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          final product = ProductDetailModel.fromJson(data);
          return Result.ok(product);
        } catch (e) {
          return Result.error(Exception("Failed to parse product detail: $e"));
        }
      },
    );
  }
}
