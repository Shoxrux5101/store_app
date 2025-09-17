import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  AuthViewModel({required AuthRepository repository})
      : _repository = repository;

  bool _isLoading = false;
  String? _error;
  dynamic _data;

  bool get isLoading => _isLoading;
  String? get error => _error;
  dynamic get data => _data;

  void _startRequest() {
    _isLoading = true;
    _error = null;
    notifyListeners();
  }

  void _finishRequest({String? error, dynamic data}) {
    _isLoading = false;
    _error = error;
    _data = data;
    notifyListeners();
  }

  Future<void> register(UserModel user) async {
    _startRequest();
    final result = await _repository.register(user);
    result.fold(
          (err) => _finishRequest(error: err.toString()),
          (success) => _finishRequest(data: success),
    );
  }

  Future<void> login(String email, String password) async {
    _startRequest();
    final result = await _repository.login(email, password);
    result.fold(
          (err) => _finishRequest(error: err.toString()),
          (success) => _finishRequest(data: success),
    );
  }

  Future<void> forgetPassword(String email) async {
    _startRequest();
    final result = await _repository.forgetPassword(email);
    result.fold(
          (err) => _finishRequest(error: err.toString()),
          (success) => _finishRequest(data: success),
    );
  }

  Future<void> sendOtp(String email) async {
    _startRequest();
    final result = await _repository.sendOtp(email);
    result.fold(
          (err) => _finishRequest(error: err.toString()),
          (success) => _finishRequest(data: success),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    _startRequest();
    final result = await _repository.verifyOtp(email, otp);
    result.fold(
          (err) => _finishRequest(error: err.toString()),
          (success) => _finishRequest(data: success),
    );
  }


  void clearData() {
    _data = null;
    _error = null;
    notifyListeners();
  }
}
