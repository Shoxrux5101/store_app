import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/review_model.dart';

class ReviewRepository {
  final ApiClient _apiClient;

  ReviewRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<ReviewModel>>> fetchReviews(int productId) async {
    final response = await _apiClient.get('/reviews/list/$productId');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final List<dynamic> data = success as List<dynamic>;
        final reviews = data
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(reviews);
      },
    );
  }
}
