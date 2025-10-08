import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_app/core/routes/router.dart';
import 'package:store_app/core/routes/routes.dart';



class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.secureStorage,});

  final FlutterSecureStorage secureStorage;
  final dio = Dio(
    BaseOptions(baseUrl: 'http://192.168.0.102:8888/api/v1',validateStatus: (status) => true),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await secureStorage.read(key: 'token');
    if(token != null){
      options.headers['Authorization'] ='Bearer $token';
    }
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if(response.statusCode == 401) {
      var login = await secureStorage.read(key: 'login');
      var password = await secureStorage.read(key: 'password');

      if(login == null || password == null) await logout();

      var result = await dio.post("/auth/login", data: {'login': login,'password': password});
      String? token = result.data["accessToken"];

      if(result.statusCode != 200 || token == null) await logout();
      await secureStorage.write (key: 'token' , value: token);
      final headers = response.requestOptions.headers;
      headers ['Authorization'] = 'Bearer $token';

      var retry = await dio.fetch(
        RequestOptions(
          baseUrl: response.requestOptions.baseUrl,
          path: response.requestOptions.path,
          method: response.requestOptions.method,
          data: response.requestOptions.data,
          headers: headers,
        ),
      );

      if(retry.statusCode != 200) await logout();
      super.onResponse(retry, handler);
    }else{
      super.onResponse(response, handler);
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'login');
    await secureStorage.delete(key: 'password');
    // AppRouter.router.go(Routes.loginPage);
    return;
  }

}