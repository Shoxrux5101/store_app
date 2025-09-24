import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/card_item_model.dart';

class CardRepository {
  final ApiClient _apiClient;

  CardRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<CardModel>>> getCards() async {
    final response = await _apiClient.get('/cards/list');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final data = (success as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
        return Result.ok(data);
      },
    );
  }
}
