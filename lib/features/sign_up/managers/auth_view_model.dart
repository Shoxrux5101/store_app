import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  AuthViewModel({required AuthRepository repository})
      : _repository = repository;

  bool isLoading = false;
  String? error;
  dynamic data;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    error = message;
    notifyListeners();
  }

  Future<void> register(UserModel user) async {
    _setLoading(true);
    error = null;

    final result = await _repository.register(user);
    result.fold(
          (err) => _setError(err.toString()),
          (success) {
        data = success;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    error = null;

    final result = await _repository.login(email, password);
    result.fold(
          (err) => _setError(err.toString()),
          (success) {
        data = success;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  Future<void> forgetPassword(String email) async {
    _setLoading(true);
    error = null;

    final result = await _repository.forgetPassword(email);
    result.fold(
          (err) => _setError(err.toString()),
          (success) {
        data = success;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

}
