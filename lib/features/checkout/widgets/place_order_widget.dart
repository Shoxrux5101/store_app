import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../managers/checkout_bloc.dart';
import '../managers/checkout_event.dart';
import '../managers/checkout_state.dart';

class PlaceOrderButtonWidget extends StatelessWidget {
  final CheckoutReady state;

  const PlaceOrderButtonWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.read<CheckoutBloc>().add(PlaceOrder()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Place Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

