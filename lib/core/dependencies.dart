import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../data/repository/auth_repository.dart';
import '../features/sign_up/managers/auth_view_model.dart';
import 'authInterceptor.dart';
import 'network/api_client.dart';

final dependencies = [
  ChangeNotifierProvider(create: (context) => AuthViewModel(repository: AuthRepository(dioClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()))))),

];