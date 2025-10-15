import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../card/managers/card_bloc.dart';
import '../../card/managers/card_state.dart';
import '../managers/checkout_bloc.dart';
import '../managers/checkout_event.dart';

class CardSelectionSheet extends StatelessWidget {
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
                const Text('Select Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                if (state is CardLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CardLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.cards.length,
                    itemBuilder: (context, index) {
                      final card = state.cards[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<CheckoutBloc>().add(SelectCard(card));
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
                              const Icon(Icons.credit_card, size: 32),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'VISA **** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Expires ${card.expiryDate}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
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
                return const Center(child: Text('No cards found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}