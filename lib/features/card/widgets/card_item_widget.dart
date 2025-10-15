import 'package:flutter/material.dart';
import 'card_logo_widget.dart';

class CardItemWidget extends StatelessWidget {
  final int id;
  final String cardNumber;
  final bool isSelected;
  final bool isDefault;
  final VoidCallback onLongPress;
  final ValueChanged<int?> onRadioChanged;

  const CardItemWidget({
    super.key,
    required this.id,
    required this.cardNumber,
    required this.isSelected,
    required this.isDefault,
    required this.onLongPress,
    required this.onRadioChanged,
  });

  String get _maskedCardNumber {
    if (cardNumber.length >= 4) {
      return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
    }
    return cardNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            CardLogoWidget(cardNumber: cardNumber),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _maskedCardNumber,
                style: const TextStyle(fontSize: 16, letterSpacing: 1),
              ),
            ),
            if (isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Default",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            const SizedBox(width: 8),
            Radio<int>(
              value: id,
              groupValue: isSelected ? id : null,
              onChanged: onRadioChanged,
            ),
          ],
        ),
      ),
    );
  }
}