import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/checkout_model.dart';


class CheckoutRepository {
  final ApiClient _apiClient;

  CheckoutRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<OrderModel>> createOrder(OrderModel order) async {
    final response = await _apiClient.post(
      '/orders/create',
      data: order.toJson(),
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(OrderModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception('Failed to create order: $e'));
        }
      },
    );
  }

  Future<Result<PromoCodeModel>> validatePromoCode(String code) async {
    final response = await _apiClient.post(
      '/promo-codes/validate',
      data: {'code': code},
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(PromoCodeModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception('Invalid promo code'));
        }
      },
    );
  }

  Future<Result<Map<String, double>>> calculateTotal({
    required double subtotal,
    String? promoCode,
  }) async {
    final response = await _apiClient.post(
      '/orders/calculate',
      data: {
        'subtotal': subtotal,
        if (promoCode != null) 'promoCode': promoCode,
      },
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok({
            'subtotal': (data['subtotal'] ?? 0).toDouble(),
            'vat': (data['vat'] ?? 0).toDouble(),
            'shippingFee': (data['shippingFee'] ?? 0).toDouble(),
            'discount': (data['discount'] ?? 0).toDouble(),
            'total': (data['total'] ?? 0).toDouble(),
          });
        } catch (e) {
          return Result.error(Exception('Failed to calculate total: $e'));
        }
      },
    );
  }
}