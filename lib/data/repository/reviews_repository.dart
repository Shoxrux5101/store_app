import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/review_model.dart';
import '../models/reviews_model.dart';

class ReviewsRepository {
  final ApiClient apiClient;

  ReviewsRepository({required this.apiClient});

  Future<Result<ReviewsModel>> createReview({
    required int productId,
    required int rating,
    String? comment,
  }) async {
    try {
      final result = await apiClient.post<Map<String, dynamic>>(
        '/reviews/create',
        data: {
          'productId': productId,
          'rating': rating,
          'comment': comment ?? '',
        },
      );

      return result.fold(
            (error) => Result.error(error),
            (data) {
          final review = ReviewModel.fromJson(data);
          return Result.ok(review as ReviewsModel);
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return Result.error(Exception(
          "Siz bu mahsulot uchun allaqachon izoh qoldirgansiz.",
        ));
      }

      return Result.error(Exception(
        "Server xatosi: ${e.response?.statusCode ?? ''} ${e.message}",
      ));
    } catch (e) {
      return Result.error(Exception('Izoh yuborishda xatolik: $e'));
    }
  }

  Future<Result<List<ReviewModel>>> getProductReviews(int productId) async {
    try {
      final result = await apiClient.get<List<dynamic>>(
        '/reviews/product/$productId',
      );

      return result.fold(
            (error) => Result.error(error),
            (data) {
          final reviews = data.map((e) => ReviewModel.fromJson(e)).toList();
          return Result.ok(reviews);
        },
      );
    } catch (e) {
      return Result.error(Exception('Failed to fetch reviews: $e'));
    }
  }
}