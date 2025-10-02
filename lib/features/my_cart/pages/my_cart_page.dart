import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/my_cart/widgets/cart_items_list.dart';
import 'package:store_app/features/my_cart/widgets/checkout%20-widget.dart';
import 'package:store_app/features/my_cart/widgets/sub_total.dart';

import '../../../core/routes/routes.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';
import '../managers/my_cart_bloc.dart';
import '../managers/my_cart_event.dart';
import '../managers/my_cart_state.dart';


class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routes.homePage,
    Routes.searchPage,
    Routes.savedPage,
    Routes.cartPage,
    Routes.accountPage,
  ];
  @override
  void initState() {
    super.initState();
    _currentIndex = 3;
    context.read<MyCartBloc>().add(LoadMyCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/Bell.svg'),
            onPressed: () {
              context.push(Routes.notification);
            },
          ),
        ],
      ),
      body: BlocBuilder<MyCartBloc, MyCartState>(
        builder: (context, state) {
          if (state is MyCartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyCartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MyCartBloc>().add(LoadMyCart());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is MyCartLoaded) {
            final cart = state.cart;
            return Column(
              children: [
                // Cart Items List
                CartItemsList(cart: cart,),
                // Total
                SubTotal(cart: cart),
                // Checkout Button
                CheckoutWidget(),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/Cart-duotone.svg',width: 64,height: 64,),
                  const Text('Your Cart Is Empty!',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),),
                  const Text('When you add products, they’ll appear here.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),maxLines: 2,),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_routes[index]);
        },
      ),
    );
  }
}