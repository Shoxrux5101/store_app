import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/saved_item_model.dart';

class SavedRepository {
  final ApiClient _apiClient;

  SavedRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<SavedItem>>> getSavedItems() async {
    final response = await _apiClient.get('/products/saved-products');

    return response.fold(
          (error) => Result.error(error),
          (success) {
          if (success is List) {
            final items = success
                .map((e) => SavedItem.fromJson(e as Map<String, dynamic>))
                .toList();
            return Result.ok(items);
          } else if (success is Map<String, dynamic> && success['data'] is List) {
            final items = (success['data'] as List)
                .map((e) => SavedItem.fromJson(e as Map<String, dynamic>))
                .toList();
            return Result.ok(items);
          }
          return const Result.ok([]);
      },
    );
  }

  Future<Result<void>> saveItem(int id) async {
    final response = await _apiClient.post('/auth/save/$id', data: {});
    return response.fold(
          (error) => Result.error(error),
          (ok) => const Result.ok(null),
    );
  }
  Future<Result<void>> unsaveItem(int id) async {
    final response = await _apiClient.post('/auth/unsave/$id', data: {});
    return response.fold(
          (error) => Result.error(error),
          (ok) => const Result.ok(null),
    );
  }
}
