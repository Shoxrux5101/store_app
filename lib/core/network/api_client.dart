import 'package:dio/dio.dart';
import '../authInterceptor.dart';
import '../utils/result.dart';

class ApiClient {
  ApiClient({required this.interceptor}){
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.104:8888/api/v1",
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        validateStatus: (status) => true,
      ),
    )..interceptors.add(
      interceptor,
    )..interceptors.add(
        LogInterceptor(
          request: true,
          // requestHeader: true,
          // requestBody: true,
          // responseHeader: true,
          // responseBody: true,
          error: true,
          // logPrint: (obj) => print(obj),
        ));
  }
  final AuthInterceptor interceptor;

  late final Dio _dio;

  Future<Result<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      var response = await _dio.get(path, queryParameters: queryParams);
      return Result.ok(response.data as T);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  Future<Result<T>> post<T>(String path, {required Map<String, dynamic> data}) async {
    try {
      var response = await _dio.post(path, data: data);
      if (response.statusCode == null || response.statusCode! < 200 || response.statusCode! >= 300) {
        return Result.error(Exception(response.data.toString()));
      }
      return Result.ok(response.data as T);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<T>> patch<T>(String path, {required Map<String, dynamic> data}) async {
    try {
      var response = await _dio.patch(path, data: data);
      if (response.statusCode != 200) {
        return Result.error(response.data);
      }
      return Result.ok(response.data as T);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<T>> delete<T>(String path) async {
    try {
      var response = await _dio.delete(path);
      if (response.statusCode == 204 || response.statusCode == 200) {
        return Result.ok(response.data as T);
      }
      return Result.error(Exception(response.data?.toString() ?? 'Delete failed'));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
