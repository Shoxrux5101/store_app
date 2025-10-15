import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/my_order_model.dart';

class MyOrderRepository {
  final ApiClient apiClient;

  MyOrderRepository({required this.apiClient});

  Future<Result<List<MyOrderModel>>> getOrders() async {
    final result = await apiClient.get('/orders/list');
    return result.fold(
          (error) => Result.error(error),
          (data) {
            // print("++++++++++++++++++++++++++");
            // print(data);
            // print("++++++++++++++++++++++++++");
        try {
          if (data is List) {
            final orders = data
                .map((json) =>
                MyOrderModel.fromJson(json as Map<String, dynamic>))
                .toList();
            return Result.ok(orders);
          }
          return Result.error(
            Exception("Unexpected response type: ${data.runtimeType}"),
          );
        } catch (e) {
          return Result.error(Exception('Failed to parse orders: $e'));
        }
      },
    );
  }

  Future<Result<int>> createOrder({
    required int addressId,
    required String paymentMethod,
    int? cardId,
    String? promoCode,
  }) async {
    final result = await apiClient.post<dynamic>(
      '/orders/create',
      data: {
        'address_id': addressId,
        'payment_method': paymentMethod,
        if (cardId != null) 'card_id': cardId,
        if (promoCode != null) 'promo_code': promoCode,
      },
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          if (data is int) {
            return Result.ok(data);
          }
          if (data is Map<String, dynamic> && data['id'] != null) {
            return Result.ok(data['id'] as int);
          }
          return Result.error(
            Exception("Unexpected response type: ${data.runtimeType}"),
          );
        } catch (e) {
          return Result.error(Exception('Failed to parse order: $e'));
        }
      },
    );
  }

  Future<Result<void>> deleteOrder(int orderId) async {
    final result = await apiClient.delete<dynamic>(
      '/orders/delete/$orderId',
    );

    return result.fold(
          (error) => Result.error(error),
          (_) => const Result.ok(null),
    );
  }

  Future<Result<Map<String, dynamic>>> getOrderTracking(int orderId) async {
    final result = await apiClient.get<dynamic>("/orders/$orderId/tracking");

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          if (data is Map<String, dynamic>) {
            return Result.ok(data);
          }
          return Result.error(
            Exception("Unexpected response type: ${data.runtimeType}"),
          );
        } catch (e) {
          return Result.error(Exception('Failed to parse tracking: $e'));
        }
      },
    );
  }
}
