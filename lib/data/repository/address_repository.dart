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
  Future<Result<Address>> getAddressById(int id) async {
    final response = await _apiClient.get('/addresses/$id');
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(Address.fromJson(success)),
    );
  }
  Future<Result<Address>> createAddress(Address address) async {
    final response = await _apiClient.post(
      '/addresses',
      data: address.toJson(),
    );
    print("===================");
    print(response);
    print("===================");

    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(Address.fromJson(success)),
    );
  }

  Future<Result<Address>> patchAddress(Address address) async {
    final response = await _apiClient.patch('/addresses/${address.id}', data: address.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(Address.fromJson(success)),
    );
  }
  Future<Result<void>> deleteAddress(int id) async {
    final response = await _apiClient.delete('/addresses/$id');
    return response.fold(
          (error) => Result.error(error),
          (_) => Result.ok(null),
    );
  }
}
