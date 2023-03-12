import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/product_section.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(headingText: "All Products")
        ],
      ),
    );
  }
}
