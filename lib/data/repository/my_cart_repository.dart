import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/my_cart_model.dart';

class MyCartRepository {
  final ApiClient _apiClient;

  MyCartRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<MyCartItemModel>> getMyCart() async {
    final response = await _apiClient.get('/cart-items');
    // print('++++++++++++++');
    // print(response);
    // print('++++++++++++++');
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
  Future<Result<MyCartItemModel>> addToMyCart(int productId, int sizeId) async {
    final response = await _apiClient.post('/cart-items', data: {
      "productId": productId,
      "sizeId": sizeId
    },);
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
    final response = await _apiClient.delete('/cart-items/$id');

    return response.fold(
          (error) => Result.error(error),
          (success) async {
        final cartResponse = await _apiClient.get('/cart-items');
        return cartResponse.fold(
              (error) => Result.error(error),
              (cartData) {
            try {
              final data = cartData as Map<String, dynamic>;
              return Result.ok(MyCartItemModel.fromJson(data));
            } catch (e) {
              return Result.error(Exception("Failed to parse cart: $e"));
            }
          },
        );
      },
    );
  }

  Future<Result<MyCartItemModel>> updateQuantity({
    required int itemId,
    required int quantity,
  }) async {
    final response = await _apiClient.patch(
      '/cart-items/$itemId',
      data: {'quantity': quantity},
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          if (success is Map<String, dynamic>) {
            return Result.ok(MyCartItemModel.fromJson(success));
          } else {
            return Result.error(Exception("No cart data returned from API"));
          }
        } catch (e) {
          return Result.error(Exception("Failed to update quantity: $e"));
        }
      },
    );
  }



}
