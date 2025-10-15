import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../address/managers/address_bloc.dart';
import '../../address/managers/address_state.dart';
import '../managers/checkout_state.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final CheckoutReady state;
  final VoidCallback onChangePressed;

  const DeliveryAddressWidget({
    required this.state,
    required this.onChangePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: onChangePressed,
              child: const Text('Change', style: TextStyle(color: Colors.blue, fontSize: 14)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<AddressBloc, AddressState>(
          builder: (context, addressState) {
            if (addressState is AddressLoaded && addressState.addresses.isNotEmpty) {
              final address = state.selectedAddress ?? addressState.addresses.first;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.location_on, color: Colors.black54, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.nickname ?? 'Home',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${address.nickname}, ${address.lat} ${address.lng}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('No address selected');
          },
        ),
      ],
    );
  }
}

