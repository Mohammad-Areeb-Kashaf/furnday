import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/product/product_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_img.dart';
import 'package:furnday/widgets/star_ratings.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const ProductScreen(
                    productName: 'Example Product',
                    productCategories: ['Furniture', 'Bed'],
                    productDescription: 'This is an example product.',
                    productMRP: '1000',
                    productDiscountedPrice: '900',
                    productImages: [
                      "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                      "https://shop.furnday.com/wp-content/uploads/2022/12/Untitled-design-1-1-300x300.jpg",
                      "https://shop.furnday.com/wp-content/uploads/2022/12/Dining-Table-Classy-300x298.jpg",
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
      child: DecoratedCard(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const ProductImg(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Product Category',
                        style: Theme.of(context).textTheme.labelMedium,
                        maxFontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Product Name',
                        style: Theme.of(context).textTheme.labelLarge,
                        maxFontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StarRating(
                      rating: 4.5,
                      color: kYellowColor,
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
                                color: kGreyMRPColor,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 18,
                              ),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: '₹900',
                              style: TextStyle(
                                color: kGreyDiscountedPriceColor,
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
            Positioned(
              top: 15,
              right: 15,
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                foregroundColor: Colors.black,
                child: IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      setState(() {
                        isFavorite = false;
                      });
                    } else {
                      setState(() {
                        isFavorite = true;
                      });
                    }
                  },
                  icon:
                      Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
