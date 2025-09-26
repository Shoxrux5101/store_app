import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';

class SavedRepository {
  final ApiClient _apiClient;

  SavedRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<Result<void>> saveItem(int id) async {
    final response = await _apiClient.post('/auth/save/$id', data: {});
    return response.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }

  Future<Result<void>> unsaveItem(int id) async {
    final response = await _apiClient.post('/auth/unsave/$id', data: {});
    return response.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }
}
