import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/core/utils/result.dart';
import '../models/card_item_model.dart';

class CardRepository {
  final ApiClient _apiClient;

  CardRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<CardModel>>> getCards() async {
    final response = await _apiClient.get('/cards');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as List<dynamic>;
          final cards = data.map((item) => CardModel.fromJson(item)).toList();
          return Result.ok(cards);
        } catch (e) {
          return Result.error(Exception("Failed to parse cards: $e"));
        }
      },
    );
  }

  Future<Result<CardModel>> addCard(String cardNumber) async {
    final response = await _apiClient.post(
      '/cards',
      data: {'cardNumber': cardNumber},
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(CardModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception("Failed to add card: $e"));
        }
      },
    );
  }

  Future<Result<void>> deleteCard(int cardId) async {
    final response = await _apiClient.delete('/cards/$cardId');

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }

  Future<Result<CardModel>> updateCard(int cardId, String cardNumber) async {
    final response = await _apiClient.patch(
      '/cards/$cardId',
      data: {'cardNumber': cardNumber},
    );

    return response.fold(
          (error) => Result.error(error),
          (success) {
        try {
          final data = success as Map<String, dynamic>;
          return Result.ok(CardModel.fromJson(data));
        } catch (e) {
          return Result.error(Exception("Failed to update card: $e"));
        }
      },
    );
  }
}