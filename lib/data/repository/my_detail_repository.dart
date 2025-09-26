import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/my_detail_model.dart';

class MyDetailRepository {
  final ApiClient _apiClient;

  MyDetailRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<MyDetailModel>>> getDetails() async {
    final response = await _apiClient.get('/mydetails/list');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final data = (success as List)
            .map((e) => MyDetailModel.fromJson(e))
            .toList();
        return Result.ok(data);
      },
    );
  }
}
