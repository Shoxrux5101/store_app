import 'package:flutter/material.dart';

class TrackingStepWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;

  const TrackingStepWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isCompleted,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = isCompleted || isActive ? colorScheme.primary : colorScheme.outline;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst)
              Container(
                width: 2,
                height: 24,
                color: isCompleted ? colorScheme.primary : colorScheme.outline,
              ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted || isActive ? colorScheme.primary : colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : icon,
                color: isCompleted || isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? colorScheme.primary : colorScheme.outline,
              ),
          ],
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: isFirst ? 8 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: activeColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}