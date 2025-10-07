import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/my_detail_model.dart';

class MyDetailRepository {
  final ApiClient _apiClient;

  MyDetailRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<MyDetail>> getDetails() async {
    final response = await _apiClient.get('/auth/me');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final data = success as Map<String, dynamic>;
        final detail = MyDetail.fromJson(data);
        return Result.ok(detail);
      },
    );
  }
}
