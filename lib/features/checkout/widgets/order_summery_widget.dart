import 'package:flutter/material.dart';
import '../managers/checkout_state.dart';

class OrderSummaryWidget extends StatelessWidget {
  final CheckoutReady state;

  const OrderSummaryWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildRow('Sub-total', '\$ ${state.subtotal.toStringAsFixed(2)}', false),
        const SizedBox(height: 12),
        _buildRow('VAT (%)', '\$ ${state.vat.toStringAsFixed(2)}', false),
        const SizedBox(height: 12),
        _buildRow('Shipping fee', '\$ ${state.shippingFee.toStringAsFixed(2)}', false),
        if (state.discount > 0) ...[
          const SizedBox(height: 12),
          _buildRow('Discount', '- \$ ${state.discount.toStringAsFixed(2)}', false),
        ],
        const Divider(height: 32),
        _buildRow('Total', '\$ ${state.total.toStringAsFixed(2)}', true),
      ],
    );
  }

  Widget _buildRow(String label, String value, bool isBold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: isBold ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

