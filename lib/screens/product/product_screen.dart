import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/screens/main_screens/my_cart_screen.dart';
import 'package:furnday/screens/product/product_3d_view_screen.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';
import 'package:furnday/widgets/product/product_price.dart';
import 'package:furnday/widgets/product/product_photo_viewer.dart';
import 'package:furnday/widgets/product/product_quantity.dart';
import 'package:furnday/widgets/product/product_review_section.dart';
import 'package:furnday/widgets/product/product_section.dart';
import 'package:furnday/widgets/star_ratings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({
    Key? key,
    required this.product,
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
                  photos: widget.product.productImages!.toList(),
                ),
                const SizedBox(height: 10),
                DecoratedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          widget.product.category
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
                              widget.product.name.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.black),
                              maxFontSize: 24,
                            ),
                            const StarRating(
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
                              mrp: widget.product.mrp.toString(),
                              discountedPrice:
                                  widget.product.discountedPrice.toString(),
                              mrpStyle: TextStyle(
                                  color: Theme.of(context).highlightColor),
                              discountedPriceStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          widget.product.product3dView == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const Product3dViewScreen(),
                                      ),
                                    ),
                                    child: const Text(
                                      "View in 3D",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DecoratedCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              widget.product.description!.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        widget.product.description![index].title
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        maxFontSize: 24,
                                      ),
                                      AutoSizeText(
                                        widget.product.description![index].desc
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProductQuantity(),
                      ),
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
                ProductSection(
                  headingText: "You might also like",
                  productGridType: ProductGridType.allProducts,
                  productServicesInstance: ProductServices(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
