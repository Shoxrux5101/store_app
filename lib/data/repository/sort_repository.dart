import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/sort_model.dart';

abstract class SortRepository {
  Future<Result<List<SortModel>>> getProducts({
    int? categoryId,
    int? sizeId,
    String? title,
    double? minPrice,
    double? maxPrice,
    String? orderBy,
  });
}

class ProductRepositoryImpl implements SortRepository {
  final ApiClient _client;

  ProductRepositoryImpl(this._client);

  @override
  Future<Result<List<SortModel>>> getProducts({
    int? categoryId,
    int? sizeId,
    String? title,
    double? minPrice,
    double? maxPrice,
    String? orderBy,
  }) async {
    final queryParams = <String, dynamic>{};

    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (sizeId != null) queryParams['sizeId'] = sizeId;
    if (title != null && title.isNotEmpty) queryParams['title'] = title;
    if (minPrice != null) queryParams['minPrice'] = minPrice;
    if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
    if (orderBy != null) queryParams['orderBy'] = orderBy;

    final result = await _client.get<dynamic>(
      '/products/list',
      queryParams: queryParams,
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          if (data is List) {
            final products = data
                .map((e) => SortModel.fromJson(e as Map<String, dynamic>))
                .toList();
            return Result.ok(products);
          } else {
            return Result.error(
              Exception('Kutilmagan javob formati: ${data.runtimeType}'),
            );
          }
        } catch (e) {
          return Result.error(Exception('Parsingda xatolik: $e'));
        }
      },
    );
  }
}
