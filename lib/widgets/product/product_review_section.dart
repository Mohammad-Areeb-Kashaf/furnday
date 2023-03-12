import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product_review_model.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/star_ratings.dart';

class ProductReviewSection extends StatelessWidget {
  final List<ProductReview> reviews;

  const ProductReviewSection({Key? key, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reviews',
              style: productNameTextStyle,
            ),
            const SizedBox(height: 8),
            if (reviews.isNotEmpty)
              Column(
                children: reviews.map((review) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            review.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.date.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      StarRating(
                        rating: review.rating,
                      ),
                      const SizedBox(height: 8),
                      Text(review.comment),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              )
            else
              const Text('No reviews yet.'),
          ],
        ),
      ),
    );
  }
}
