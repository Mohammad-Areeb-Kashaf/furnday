import 'package:furnday/constants.dart';

class ProductPrice extends StatelessWidget {
  final String mrp;
  final String discountedPrice;
  final TextStyle? mrpStyle;
  final TextStyle? discountedPriceStyle;

  const ProductPrice({
    Key? key,
    required this.mrp,
    required this.discountedPrice,
    this.mrpStyle,
    this.discountedPriceStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '₹$mrp', style: kProductMRPTextStyle.merge(mrpStyle)),
          const TextSpan(text: ' '),
          TextSpan(
              text: '₹$discountedPrice',
              style: kProductDiscountPriceTextStyle.merge(discountedPriceStyle))
        ],
      ),
    );
  }
}
