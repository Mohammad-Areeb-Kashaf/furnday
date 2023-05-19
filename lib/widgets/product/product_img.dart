import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class ProductImg extends StatelessWidget {
  const ProductImg({super.key, this.height, this.width});
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusCard,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: height,
        width: width,
        imageUrl: "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
      ),
    );
  }
}
