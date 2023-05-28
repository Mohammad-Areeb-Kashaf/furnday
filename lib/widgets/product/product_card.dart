import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/screens/product/product_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_img.dart';
import 'package:furnday/widgets/star_ratings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:furnday/widgets/product/product_price.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

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
            builder: (context) => ProductScreen(
              product: widget.product,
            ),
          ),
        );
      },
      child: DecoratedCard(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ProductImg(
                images: widget.product.productImages!.toList(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.product.category!
                        .toList()
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(
                          ']',
                          '',
                        ),
                    style: Theme.of(context).textTheme.labelMedium,
                    maxFontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.product.name.toString(),
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
                  child: ProductPrice(
                    mrp: widget.product.mrp.toString(),
                    mrpStyle: kProductMRPTextStyle,
                    discountedPrice: widget.product.discountedPrice.toString(),
                    discountedPriceStyle: kProductDiscountPriceTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
