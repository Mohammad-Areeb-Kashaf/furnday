import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/product_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/star_ratings.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const ProductScreen(
                    productName: 'Example Product',
                    productDescription: 'This is an example product.',
                    productPrice: '9.99',
                    productImages: [
                      "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                      "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                      "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                    ],
                    reviews: [
                      {
                        'user': 'User1',
                        'comment': 'This product is great!',
                        'rating': 5,
                      },
                      {
                        'user': 'User2',
                        'comment': 'This product is okay.',
                        'rating': 3,
                      },
                      {
                        'user': 'User3',
                        'comment': 'This product is not very good.',
                        'rating': 2,
                      },
                    ],
                  )),
        );
      },
      child: GridTile(
        child: DecoratedCard(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: borderRadiusCard,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Product Category',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: greyTextColor),
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Product Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StarRating(
                    rating: 4.5,
                    color: yellowColor,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '₹1000',
                            style: TextStyle(
                              color: greyMRPColor,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 18,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: '₹900',
                            style: TextStyle(
                              color: greyDiscountedPriceColor,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
