import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/product_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/star_ratings.dart';

class ProductCard extends StatefulWidget {
  ProductCard({super.key});

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
          MaterialPageRoute(
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
                          fontSize: 12,
                          color: greyTextColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Product Name',
                          style: productNameTextStyle.copyWith(
                            fontSize: 16,
                          )),
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
            Positioned(
              top: 15,
              left: 135,
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
