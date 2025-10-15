import 'package:flutter/material.dart';

class EmptyOrdersWidget extends StatelessWidget {
  final bool isOngoing;

  const EmptyOrdersWidget({required this.isOngoing});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isOngoing ? 'No Ongoing Orders!' : 'No Completed Orders!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isOngoing
                  ? 'You don\'t have any ongoing orders\nat this time.'
                  : 'You haven\'t completed any\norders yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}