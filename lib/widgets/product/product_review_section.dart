import 'package:furnday/constants.dart';

class ProductReviewSection extends StatelessWidget {
  final List<ProductReviews>? reviews;
  final String productId;

  const ProductReviewSection(
      {Key? key, required this.reviews, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'Reviews',
              style: Theme.of(context).textTheme.labelLarge,
              minFontSize: 18,
              maxFontSize: 24,
            ),
            const SizedBox(height: 8),
            (reviews!.isNotEmpty)
                ? Column(
                    children: reviews!.map((review) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              AutoSizeText(
                                review.username.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxFontSize: 20,
                              ),
                              const SizedBox(width: 8),
                              AutoSizeText(
                                review.date.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          StarRating(
                            rating: review.rating!.toDouble(),
                          ),
                          const SizedBox(height: 8),
                          AutoSizeText(review.comment.toString()),
                          const SizedBox(height: 16),
                          const Divider(thickness: 1),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  )
                : const AutoSizeText('No reviews yet.'),
          ],
        ),
      ),
    );
  }
}
