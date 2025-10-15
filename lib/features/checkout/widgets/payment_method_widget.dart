import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../card/managers/card_bloc.dart';
import '../../card/managers/card_state.dart';
import '../managers/checkout_bloc.dart';
import '../managers/checkout_event.dart';
import '../managers/checkout_state.dart';

class PaymentMethodWidget extends StatelessWidget {
  final CheckoutReady state;
  final VoidCallback onCardSelectPressed;

  const PaymentMethodWidget({
    required this.state,
    required this.onCardSelectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildButton(context, 'Card', Icons.credit_card, 'card'),
            const SizedBox(width: 12),
            _buildButton(context, 'Cash', Icons.money, 'cash'),
            const SizedBox(width: 12),
            _buildButton(context, 'Pay', Icons.apple, 'apple_pay'),
          ],
        ),
        if (state.paymentMethod == 'card') ...[
          const SizedBox(height: 16),
          _buildCardSelection(context),
        ],
      ],
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, String method) {
    final isSelected = state.paymentMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<CheckoutBloc>().add(SelectPaymentMethod(method)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSelection(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, cardState) {
        if (cardState is CardLoaded && cardState.cards.isNotEmpty) {
          final card = state.selectedCard ?? cardState.cards.first;
          return GestureDetector(
            onTap: onCardSelectPressed,
            child: Container(
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
                    child: Text(
                      'VISA **** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Icon(Icons.edit, size: 20, color: Colors.grey),
                ],
              ),
            ),
          );
        }
        return TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add Card'),
        );
      },
    );
  }
}

