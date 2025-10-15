import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../address/managers/address_bloc.dart';
import '../../address/managers/address_state.dart';
import '../managers/checkout_bloc.dart';
import '../managers/checkout_event.dart';

class AddressSelectionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AddressLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.addresses.length,
                    itemBuilder: (context, index) {
                      final address = state.addresses[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<CheckoutBloc>().add(SelectAddress(address));
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
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
                                    Text(address.nickname ?? 'Home', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(address.nickname, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No addresses found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

