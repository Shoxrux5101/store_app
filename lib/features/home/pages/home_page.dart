import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';
import '../../../core/authInterceptor.dart';
import '../../../core/network/api_client.dart';
import '../../../data/repository/category_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/saved_repository.dart';
import '../managers/home_cubit.dart';
import '../managers/product_bloc.dart';
import '../managers/product_event.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/products_grid_widget.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductRepository _productRepository;
  late final SavedRepository _savedRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit(
            CategoryRepository(
              apiClient: ApiClient(
                interceptor: AuthInterceptor(
                  secureStorage: FlutterSecureStorage(),
                ),
              ),
            ),
          )..fetchCategories(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProductBloc(
            repository: ProductRepository(
              apiClient: ApiClient(
                interceptor: AuthInterceptor(
                  secureStorage: FlutterSecureStorage(),
                ),
              ),
            ),
          )..add(GetAllProductsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () => context.push(Routes.notification),
                  icon: SvgPicture.asset("assets/icons/Bell.svg"),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBarWidget(),
              SizedBox(height: 16),
              CategoryTabsWidget(),
              SizedBox(height: 16),
              ProductsGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
