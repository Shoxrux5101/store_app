import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/data/repository/card_item_repository.dart';
import 'package:store_app/data/repository/notification_repository.dart';
import 'package:store_app/data/repository/product_detail_repository.dart';
import 'package:store_app/data/repository/product_repository.dart';
import 'package:store_app/data/repository/review_repository.dart';
import 'package:store_app/features/card/managers/card_bloc.dart';
import 'package:store_app/features/card/managers/card_event.dart';
import 'package:store_app/features/notification/managers/notification_bloc.dart';
import 'package:store_app/features/product_details/managers/product_detail_bloc.dart';
import 'package:store_app/features/review/managers/review_bloc.dart';
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
  Provider(create: (context) => NotificationRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())))),
  Provider(create: (context) => ProductRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())))),
  Provider(create: (context) => ProductDetailRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())))),
  Provider(create: (context) => ReviewRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())))),
  Provider(create: (context) => CardRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())))),



  BlocProvider(create: (context) => HomeCubit(context.read<CategoryRepository>())),
  BlocProvider(create: (context) => NotificationBloc(context.read<NotificationRepository>(),)..add(NotificationEventFetch())),
  BlocProvider(create: (context) => ReviewBloc(repository: context.read<ReviewRepository>())),
  BlocProvider(create: (context) => ProductDetailBloc(repository: context.read<ProductDetailRepository>(),),),
  BlocProvider(create: (context) => CardBloc(repository: context.read<CardRepository>())..add(LoadCards()))





];
