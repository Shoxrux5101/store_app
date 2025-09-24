import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/review_stats.dart';

class ReviewStatsRepository {
  final ApiClient _apiClient;

  ReviewStatsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<ReviewStatsModel>> fetchReviewStats(int productId) async {
    final response = await _apiClient.get('/reviews/stats/$productId');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final data = success as Map<String, dynamic>;
        final stats = ReviewStatsModel.fromJson(data);
        return Result.ok(stats);
      },
    );
  }
}
