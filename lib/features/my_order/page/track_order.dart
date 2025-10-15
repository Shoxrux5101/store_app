import 'package:flutter/material.dart';
import 'package:store_app/data/models/my_order_model.dart';

import '../../home/widgets/cutom_app_bar.dart';
import '../widgets/track_step_widget.dart';



class TrackOrderPage extends StatelessWidget {
  final MyOrderModel order;

  const TrackOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Track Order",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          order.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: colorScheme.surfaceVariant,
                            child: Icon(Icons.image, color: colorScheme.onSurface),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Size: ${order.size}',
                              style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: colorScheme.outline.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.orderNumber,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${order.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Order Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24),
            TrackingStepWidget(
              icon: Icons.inventory_2,
              title: 'Packing',
              subtitle: 'Order is being packed',
              isActive: _isStepActive('packing', order.status),
              isCompleted: _isStepCompleted('packing', order.status),
              isFirst: true,
            ),
            TrackingStepWidget(
              icon: Icons.local_shipping,
              title: 'Picked',
              subtitle: 'Package picked by courier',
              isActive: _isStepActive('picked', order.status),
              isCompleted: _isStepCompleted('picked', order.status),
            ),
            TrackingStepWidget(
              icon: Icons.airport_shuttle,
              title: 'In Transit',
              subtitle: 'Package is on the way',
              isActive: _isStepActive('in_transit', order.status),
              isCompleted: _isStepCompleted('in_transit', order.status),
            ),
            TrackingStepWidget(
              icon: Icons.check_circle,
              title: 'Delivered',
              subtitle: 'Package delivered successfully',
              isActive: _isStepActive('completed', order.status),
              isCompleted: _isStepCompleted('completed', order.status),
              isLast: true,
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person,
                      color: colorScheme.onSurface,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jacob Jones',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Delivery Guy',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.phone, color: colorScheme.onSurface),
                      onPressed: () {
                        // Call functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isStepActive(String step, String currentStatus) {
    final statusLower = currentStatus.toLowerCase();
    final stepLower = step.toLowerCase();
    return statusLower == stepLower ||
        (stepLower == 'in_transit' && statusLower == 'in transit');
  }

  bool _isStepCompleted(String step, String currentStatus) {
    final steps = ['packing', 'picked', 'in_transit', 'completed'];
    final currentIndex = _getStatusIndex(currentStatus);
    final stepIndex = steps.indexOf(step.toLowerCase());
    return currentIndex > stepIndex;
  }

  int _getStatusIndex(String status) {
    final statusLower = status.toLowerCase();
    switch (statusLower) {
      case 'packing':
        return 0;
      case 'picked':
        return 1;
      case 'in_transit':
      case 'in transit':
        return 2;
      case 'completed':
        return 3;
      default:
        return -1;
    }
  }
}