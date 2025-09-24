import 'package:flutter/material.dart';

class ReviewHeader extends StatelessWidget {
  final double averageRating;
  final int reviewCount;

  const ReviewHeader({
    super.key,
    required this.averageRating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 18),
            Column(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < averageRating.round()
                          ? Icons.star
                          : Icons.star,
                      color: index < averageRating.round()? Colors.amber : Colors.grey[400],
                      size: 28,
                    );
                  }),
                ),
                Text(
                  "1034 Ratings",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF808080),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$reviewCount Reviews",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: const [
                Text(
                  "Most Relevant",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
