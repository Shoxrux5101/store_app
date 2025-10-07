import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessDialog({
    super.key,
    this.title = "Congratulations!",
    this.message = "Your new address has been added.",
    this.buttonText = "Thanks",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green check icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade50,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 48),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show dialog
void showSuccessDialog(BuildContext context, {VoidCallback? onClose}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SuccessDialog(
      onPressed: () {
        Navigator.pop(context); // dialog yopiladi
        if (onClose != null) onClose();
      },
    ),
  );
}
