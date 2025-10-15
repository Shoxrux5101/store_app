import 'package:flutter/material.dart';

import 'card_type_detector.dart';

class CardLogoWidget extends StatelessWidget {
  final String cardNumber;

  const CardLogoWidget({
    super.key,
    required this.cardNumber,
  });

  @override
  Widget build(BuildContext context) {
    final cardType = CardTypeDetector.detectCardType(cardNumber);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        cardType,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}