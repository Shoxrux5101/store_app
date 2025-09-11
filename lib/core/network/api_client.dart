// import 'package:dio/dio.dart';
//
// class ApiClient {
//   ApiClient (){
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: "",
//         connectTimeout: Duration(seconds: 5),
//         receiveTimeout: Duration(seconds: 3),
//         validateStatus: (status) => true,
//       ),
//     )..interceptors.add(interceptor);
//   }
//   final AuthInterceptor interceptor;
//   late final Dio dio;
// }