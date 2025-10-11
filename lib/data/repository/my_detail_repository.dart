import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/my_detail_model.dart';

class MyDetailRepository {
  final ApiClient _apiClient;

  MyDetailRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<MyDetail>> getMyDetail() async {
    final response = await _apiClient.get('/auth/me');

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(MyDetail.fromJson(success)),
    );
  }

  Future<Result<MyDetail>> updateMyDetail(MyDetail myDetail) async {
    final response = await _apiClient.patch(
      '/auth/update',
      data: myDetail.toJson(),
    );

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(MyDetail.fromJson(success)),
    );
  }

  Future<Result<void>> registerMyDetail() async {
    final response = await _apiClient.post('/auth/register', data: {});

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }
}