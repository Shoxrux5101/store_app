import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/address_model.dart';

class AddressRepository {
  final ApiClient _apiClient;

  AddressRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<Address>>> getAddresses() async {
    final response = await _apiClient.get('/addresses');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final data = (success as List)
            .map((e) => Address.fromJson(e))
            .toList();
        return Result.ok(data);
      },
    );
  }

  Future<Result<Address>> createAddress(Address address) async {
    final response = await _apiClient.post('/addresses/create', data: address.toJson(),);

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(Address.fromJson(success)),
    );
  }
}
