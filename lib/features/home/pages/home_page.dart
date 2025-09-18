import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/authInterceptor.dart';
import '../../../core/network/api_client.dart';
import '../../../data/repository/category_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../managers/home_cubit.dart';
import '../managers/product_cubit.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/products_grid_widget.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit(
            CategoryRepository(
              apiClient: ApiClient(
                interceptor: AuthInterceptor(
                  secureStorage: const FlutterSecureStorage(),
                ),
              ),
            ),
          )..fetchCategories(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProductCubit(
            ProductRepository(
              apiClient: ApiClient(
                interceptor: AuthInterceptor(
                  secureStorage: const FlutterSecureStorage(),
                ),
              ),
            ),
          )..fetchProducts(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discover",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500,),),
                IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/icons/Bell.svg")),
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
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}
