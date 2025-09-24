import 'package:flutter/material.dart';
import 'package:store_app/features/review/widgets/review_item.dart';
import '../../../data/models/review_model.dart';


class ReviewList extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewItem(review: reviews[index]);
      },
    );
  }
}
