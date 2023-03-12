import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product_review_model.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_price.dart';
import 'package:furnday/widgets/product/product_photo_viewer.dart';
import 'package:furnday/widgets/product/product_quantity.dart';
import 'package:furnday/widgets/product/product_review_section.dart';
import 'package:furnday/widgets/product/product_section.dart';
import 'package:furnday/widgets/star_ratings.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  final String productName;
  final List<String> productCategories;
  final String productDescription;
  final String productMRP;
  final String productDiscountedPrice;
  final List<String> productImages;
  final List<Map<String, dynamic>> reviews;

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
      ),
      backgroundColor: whiteBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: scrollPhysics,
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
                      child: Text(
                        widget.productCategories
                            .toString()
                            .replaceAll("[", '')
                            .replaceAll(']', ''),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: greyTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productName,
                            style: productNameTextStyle.copyWith(
                                color: Colors.black),
                          ),
                          StarRating(
                            rating: 4.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ProductPrice(
                        mrp: double.parse(widget.productMRP),
                        discountedPrice:
                            double.parse(widget.productDiscountedPrice),
                        mrpStyle:
                            TextStyle(color: Theme.of(context).highlightColor),
                        discountedPriceStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DecoratedCard(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Details",
                                style: productNameTextStyle,
                              ),
                              Text(
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
                  child: const Text(
                    'Customize',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_shopping_cart,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          whiteBackground,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: borderRadiusCard,
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
                        borderRadius: borderRadiusCard,
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ProductReviewSection(
                reviews: [
                  ProductReview(
                      username: 'FurnDay User',
                      date: DateFormat("yyyy-MM--dd")
                          .format(DateTime.utc(2023, 3, 12)),
                      rating: 4.5,
                      comment: "Very Good Product"),
                  ProductReview(
                      username: 'FurnDay User',
                      date: DateFormat("yyyy-MM--dd")
                          .format(DateTime.parse("20230312")),
                      rating: 4.5,
                      comment: "Very Good Product"),
                  ProductReview(
                      username: 'FurnDay User',
                      date: DateFormat("yyyy-MM--dd")
                          .format(DateTime.parse("20230312")),
                      rating: 4.5,
                      comment: "Very Good Product"),
                  ProductReview(
                      username: 'FurnDay User',
                      date: DateFormat("yyyy-MM--dd")
                          .format(DateTime.parse("20230312")),
                      rating: 4.5,
                      comment: "Very Good Product"),
                  ProductReview(
                      username: 'FurnDay User',
                      date: DateFormat("yyyy-MM--dd")
                          .format(DateTime.parse("20230312")),
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
    );
  }
}
