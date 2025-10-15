import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';
import '../managers/my_cart_bloc.dart';
import '../managers/my_cart_state.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCartBloc, MyCartState>(
      builder: (context, state) {
        double subtotal = 0.0;

        if (state is MyCartLoaded) {
          subtotal = state.cart.subTotal;
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {
              if (state is MyCartLoaded) {
                context.push(
                  Routes.checkOut,
                  extra: subtotal,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Go To Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}