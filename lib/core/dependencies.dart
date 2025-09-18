import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../features/sign_up/managers/auth_view_model.dart';
import '../features/home/managers/home_cubit.dart';
import 'authInterceptor.dart';
import 'network/api_client.dart';

final dependencies = <SingleChildWidget>[
  ChangeNotifierProvider(
    create: (context) => AuthViewModel(
      repository: AuthRepository(dioClient: ApiClient(interceptor: AuthInterceptor(secureStorage: const FlutterSecureStorage(),),),),),),

  Provider(
    create: (context) => CategoryRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: const FlutterSecureStorage(),),),),),
  BlocProvider(create: (context) => HomeCubit(context.read<CategoryRepository>())),
];
