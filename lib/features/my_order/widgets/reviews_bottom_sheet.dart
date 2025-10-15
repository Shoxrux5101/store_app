import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/authInterceptor.dart';
import '../../../core/network/api_client.dart';
import '../../../data/models/my_order_model.dart';
import '../../../data/repository/reviews_repository.dart';
import '../managers/my_order_bloc.dart';
import '../managers/my_order_event.dart';

class ReviewBottomSheet extends StatefulWidget {
  final MyOrderModel order;
  final ApiClient apiClient;
  final OrderBloc orderBloc;

  const ReviewBottomSheet({
    required this.order,
    required this.apiClient,
    required this.orderBloc,
  });

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  late int _rating;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _rating = widget.order.rating ?? 0;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leave a Review',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: colorScheme.onSurface),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 24,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'How was your order?',
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _rating = index + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        size: 44,
                        color: Colors.amber,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _commentController,
                maxLines: 4,
                maxLength: 500,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  hintText: 'Write your review... (optional)',
                  hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.4)),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.onPrimary),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.onPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.onPrimary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _rating > 0 && !_isSubmitting ? _submitReview : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onSurface,
                    foregroundColor: colorScheme.onPrimary,
                    disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.onSecondary,
                    ),
                  )
                      : Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    setState(() => _isSubmitting = true);

    try {
      final reviewRepo = ReviewsRepository(apiClient:ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage())));

      await reviewRepo.createReview(
        productId: widget.order.id,
        rating: _rating,
        comment: _commentController.text.trim(),
      );

      widget.order.rating = _rating;

      if (mounted) {
        Navigator.pop(context);
        widget.orderBloc.add(LoadOrdersEvent());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Review submitted successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) setState(() => _isSubmitting = false);

      String errorMessage = 'Error: ${e.toString()}';
      if (e.toString().contains('409') ||
          e.toString().toLowerCase().contains('already exists') ||
          e.toString().toLowerCase().contains('duplicate')) {
        errorMessage = 'You have already reviewed this order!';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(errorMessage)),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }
}