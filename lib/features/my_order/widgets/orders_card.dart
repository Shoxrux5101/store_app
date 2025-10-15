import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/my_order_model.dart';
import 'package:store_app/features/my_order/managers/reviews_bloc.dart';
import 'package:store_app/features/my_order/widgets/reviews_bottom_sheet.dart';
import '../../../core/network/api_client.dart';
import '../../../data/repository/reviews_repository.dart' show ReviewsRepository;
import '../managers/my_order_bloc.dart';
import '../managers/my_order_event.dart';
import '../page/track_order.dart';

class OrderCard extends StatelessWidget {
  final MyOrderModel order;
  const OrderCard({required this.order, super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = order.status.toLowerCase().contains('completed');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    order.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 70,
                      color: colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.image_outlined,
                        size: 28,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Size ${order.size}',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$ ${order.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(context, order.status)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getStatusText(order.status),
                    style: TextStyle(
                      fontSize: 11,
                      color: _getStatusColor(context, order.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => _showReviewDialog(context, order),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            (order.rating != null && order.rating! > 0)
                                ? '${order.rating!.toStringAsFixed(1)}/5'
                                : 'Rate',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 85,
                  height: 28,
                  child: ElevatedButton(
                    onPressed: isCompleted
                        ? () => _showReviewDialog(context, order)
                        : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrackOrderPage(order: order),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.onPrimary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isCompleted ? 'Review' : 'Track',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in_transit':
      case 'in transit':
        return Colors.blue;
      case 'picked':
        return Colors.orange;
      case 'packing':
        return Colors.purple;
      case 'cancelled':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.onSurface.withOpacity(0.7);
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'in_transit':
      case 'in transit':
        return 'In Transit';
      case 'picked':
        return 'Picked';
      case 'packing':
        return 'Packing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
  void _showReviewDialog(BuildContext context, MyOrderModel order) {
    final apiClient = context.read<ApiClient>();
    final orderBloc = context.read<OrderBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final reviewRepo = ReviewsRepository(apiClient: apiClient);
        return BlocProvider(
          create: (_) => ReviewsBloc(reviewRepo),
          child: ReviewBottomSheet(
            order: order,
            apiClient: apiClient,
            orderBloc: orderBloc,
          ),
        );
      },
    ).then((_) => orderBloc.add(LoadOrdersEvent()));
  }
}
