import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/screens/main_screens/my_cart_screen.dart';
import 'package:furnday/screens/product/product_3d_view.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/product/product_price.dart';
import 'package:furnday/widgets/product/product_photo_viewer.dart';
import 'package:furnday/widgets/product/product_quantity.dart';
import 'package:furnday/widgets/product/product_review_section.dart';
import 'package:furnday/widgets/product/product_section.dart';
import 'package:furnday/widgets/star_ratings.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;

class ProductScreen extends StatefulWidget {
  final String productName;
  final List<String> productCategories;
  final String productDescription;
  final String productMRP;
  final String productDiscountedPrice;
  final List<String> productImages;
  final List<ProductReviews> reviews;

  const ProductScreen({
    Key? key,
    required this.productName,
    required this.productCategories,
    required this.productDescription,
    required this.productMRP,
    required this.productDiscountedPrice,
    required this.productImages,
    required this.reviews,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        floatingActionButton: badges.Badge(
          position: badges.BadgePosition.custom(top: -5, end: 0),
          badgeContent: const Text('3'),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const MyCartScreen(),
              ),
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: kWhiteBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: kScrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductPhotoViewer(
                  photos: widget.productImages,
                ),
                const SizedBox(height: 10),
                DecoratedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          widget.productCategories
                              .toString()
                              .replaceAll("[", '')
                              .replaceAll(']', ''),
                          style: Theme.of(context).textTheme.labelMedium,
                          maxFontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              widget.productName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.black),
                              maxFontSize: 24,
                            ),
                            StarRating(
                              rating: 4.5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ProductPrice(
                              mrp: widget.productMRP,
                              discountedPrice: widget.productDiscountedPrice,
                              mrpStyle: TextStyle(
                                  color: Theme.of(context).highlightColor),
                              discountedPriceStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const Product3dView(),
                                ),
                              ),
                              child: const Text(
                                "View in 3D",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DecoratedCard(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Details",
                                  style: Theme.of(context).textTheme.labelLarge,
                                  maxFontSize: 24,
                                ),
                                const AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget maximus mauris, ut dapibus eros. Duis ultricies posuere euismod. Etiam vel lacus sapien. Mauris fringilla vestibulum dignissim. Phasellus dui turpis, commodo vel elit non, cursus vestibulum urna. Vivamus sagittis nisl et sapien lobortis porta. In est velit, tristique nec lacus vel, rhoncus commodo arcu. Cras vulputate tellus ac nisi interdum, a feugiat nunc vestibulum. Ut ac ornare ligula, in tempor diam. Duis vitae ante et enim rutrum varius ac nec mi. Nulla nulla nisl, pellentesque eget ultrices aliquam, blandit eu quam. Fusce ut porta nisl, et tristique est. Proin eget.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ProductQuantity(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const AutoSizeText(
                      'Customize',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      maxFontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        label: const AutoSizeText(
                          'Add to Cart',
                          maxFontSize: 24,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_shopping_cart,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            kWhiteBackground,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: kBorderRadiusCard,
                            ),
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: kBorderRadiusCard,
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                        child: AutoSizeText(
                          'Buy Now',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxFontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ProductReviewSection(
                  reviews: [
                    ProductReviews(
                        username: 'FurnDay User',
                        date: "22/5/2023",
                        rating: 4.5,
                        comment: "Very Good Product"),
                  ],
                ),
                const SizedBox(height: 10),
                const ProductSection(headingText: "You might also like"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
