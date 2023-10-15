import 'package:furnday/constants.dart';

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
              productId: widget.product.id,
            ),
          ),
        );
      },
      child: DecoratedCard(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ProductImg(
                  image: widget.product.productImages![0],
                ),
                Align(
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
                    minFontSize: 10,
                    maxFontSize: 18,
                    maxLines: 2,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.product.name.toString(),
                    style: Theme.of(context).textTheme.labelLarge,
                    minFontSize: 12,
                    maxFontSize: 24,
                    maxLines: 2,
                  ),
                ),
                const StarRating(
                  rating: 4.5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ProductPrice(
                    mrp: widget.product.mrp.toString(),
                    mrpStyle: kProductMRPTextStyle,
                    discountedPrice: widget.product.discountedPrice.toString(),
                    discountedPriceStyle: kProductDiscountPriceTextStyle,
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
