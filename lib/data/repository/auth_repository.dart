import '../../core/network/api_client.dart';
import '../../core/utils/result.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _dioClient;
  AuthRepository({required ApiClient dioClient}) : _dioClient = dioClient;

  Future<Result> register(UserModel user) async {
    final response = await _dioClient.post(
      "/auth/register",
      data: user.toJson(),
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> login(String email, String password) async {
    final response = await _dioClient.post(
      "/auth/login",
      data: {"login": email, "password": password},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }
  Future<Result> resetPassword(String email, String otp, String newPassword) async {
    final response = await _dioClient.post(
      "/auth/reset-password/reset",
      data: {
        "login": email,
        "otp": otp,
        "newPassword": newPassword
      },
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> forgetPassword(String email) async {
    final response = await _dioClient.post(
      "/auth/reset-password/email",
      data: {"login": email},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> verify(String email) async {
    final response = await _dioClient.post(
      "/auth/reset-password/verify",
      data: {"login": email},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }

  Future<Result> verifyOtp(String email, String otp) async {
    final response = await _dioClient.post(
      "/auth/reset-password/reset",
      data: {"login": email, "otp": otp},
    );
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }
}
