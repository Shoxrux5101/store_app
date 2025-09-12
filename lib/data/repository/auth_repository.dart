

import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _dioClient;
  AuthRepository({required ApiClient dioClient}) : _dioClient = dioClient;

  Future<Result> register(UserModel user) async {
    final response = await _dioClient.post(
      "/sign-up",
      data: user.toJson(),
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> login(String email, String password) async {
    final response = await _dioClient.post(
      "/login",
      data: {"email": email, "password": password},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> forgetPassword(String email) async {
    final response = await _dioClient.post(
      "/forget-password",
      data: {"email": email},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> otpCode(String code) async {
    final response = await _dioClient.post(
      "/otp-code",
      data: {"code": code},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }
}
