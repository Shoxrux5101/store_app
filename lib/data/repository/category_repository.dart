import 'dart:convert';
import 'package:strore_app/core/network/api_client.dart';

import '../../core/utils/result.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<CategoryModel>>> getCategories() async {
    final response = await _apiClient.get('/categories/list');
    print(response);
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }
}
