import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/my_cart_model.dart';

class MyCartRepository {
  final ApiClient _apiClient;

  MyCartRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<MyCartItemModel>> getMyCart() async {
    final response = await _apiClient.get('/my-cart/my-cart-items');
    print('++++++++++++++');
    print(response);
    print('++++++++++++++');
    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(MyCartItemModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception("Failed to parse my cart: $e"));
        }
      },
    );
  }

  Future<Result<MyCartItemModel>> addToMyCart(MyCartProductItem item) async {
    final response = await _apiClient.post('/my-cart/add-item', data: item.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(MyCartItemModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception("Failed to parse added cart item: $e"));
        }
      },
    );
  }

  Future<Result<MyCartItemModel>> removeFromMyCart(int id) async {
    final response = await _apiClient.delete('/my-cart/delete/$id');
    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(MyCartItemModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception("Failed to parse removed cart item: $e"));
        }
      },
    );
  }

}
