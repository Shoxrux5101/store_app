import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/data/repository/address_repository.dart';
import 'package:store_app/data/repository/card_item_repository.dart';
import 'package:store_app/data/repository/my_detail_repository.dart';
import 'package:store_app/data/repository/notification_repository.dart';
import 'package:store_app/data/repository/product_detail_repository.dart';
import 'package:store_app/data/repository/product_repository.dart';
import 'package:store_app/data/repository/review_repository.dart';
import 'package:store_app/data/repository/saved_repository.dart';
import 'package:store_app/features/address/managers/address_bloc.dart';
import 'package:store_app/features/address/managers/address_event.dart';
import 'package:store_app/features/card/managers/card_bloc.dart';
import 'package:store_app/features/card/managers/card_event.dart';
import 'package:store_app/features/chat/managers/chat_bloc.dart';
import 'package:store_app/features/chat/page/chat_page.dart';
import 'package:store_app/features/home/managers/category_cubit.dart';
import 'package:store_app/features/notification/managers/notification_bloc.dart';
import 'package:store_app/features/product_details/managers/product_detail_bloc.dart';
import 'package:store_app/features/review/managers/review_bloc.dart';
import 'package:store_app/features/saved/managers/saved_bloc.dart';
import 'package:store_app/features/saved/managers/saved_event.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../features/sign_up/managers/auth_view_model.dart';
import '../data/repository/my_cart_repository.dart';
import '../features/home/managers/home_cubit.dart';
import '../features/home/managers/product_bloc.dart';
import '../features/home/managers/product_event.dart';
import '../features/my_cart/managers/my_cart_bloc.dart';
import '../features/my_cart/managers/my_cart_event.dart';
import '../features/my_details/manager/my_detail_bloc.dart';
import '../features/my_details/manager/my_detail_event.dart';
import 'authInterceptor.dart';
import 'network/api_client.dart';

final dependencies = <SingleChildWidget>[
  ChangeNotifierProvider(
    create: (context) => AuthViewModel(
      repository: AuthRepository(
        dioClient: ApiClient(
          interceptor: AuthInterceptor(
            secureStorage: FlutterSecureStorage(),
          ),
        ),
      ),
    ),
  ),

  Provider(
    create: (context) => CategoryRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(
          secureStorage: FlutterSecureStorage(),
        ),
      ),
    ),
  ),
  Provider(
    create: (context) => NotificationRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => ProductRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => ProductDetailRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => ReviewRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => CardRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => SavedRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => MyCartRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  // Provider(
  //   create: (context) => CategoryRepository(
  //     apiClient: ApiClient(
  //       interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
  //     ),
  //   ),
  // ),
  Provider(
    create: (context) => MyDetailRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => AddressRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),
  Provider(
    create: (context) => CardRepository(
      apiClient: ApiClient(
        interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()),
      ),
    ),
  ),

  BlocProvider(
    create: (context) => HomeCubit(
      context.read<CategoryRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) =>
        CategoryCubit(context.read<CategoryRepository>())..fetchCategories(),
  ),
  BlocProvider(
    create: (context) => NotificationBloc(
      context.read<NotificationRepository>(),
    )..add(NotificationEventFetch()),
  ),
  BlocProvider(
    create: (context) =>
        ReviewBloc(repository: context.read<ReviewRepository>()),
  ),
  BlocProvider(
    create: (context) => ProductDetailBloc(
      repository: context.read<ProductDetailRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) => CardBloc(
      repository: context.read<CardRepository>(),
    )..add(LoadCards()),
  ),
  BlocProvider(
    create: (context) => ProductBloc(
      repository: context.read<ProductRepository>(),
    )..add(GetAllProductsEvent()),
  ),
  BlocProvider(
    create: (context) => SavedBloc(
      repository: context.read<SavedRepository>(),
    )..add(LoadSavedItems()),
  ),
  BlocProvider(
    create: (context) => MyCartBloc(
      repository: context.read<MyCartRepository>(),
    )..add(LoadMyCart()),
  ),
  BlocProvider(
    create: (context) => MyDetailBloc(
      repository: context.read<MyDetailRepository>(),
    )..add(LoadMyDetail()),
  ),
  BlocProvider(
    create: (context) => AddressBloc(
      context.read<AddressRepository>(),
    )..add(LoadAddresses()),
  ),
  BlocProvider(
    create: (context) => ChatBloc(),
    child: ChatPage(),
  ),
  BlocProvider(create: (context) =>CardBloc(repository: context.read<CardRepository>())..add(LoadCards())),

];
