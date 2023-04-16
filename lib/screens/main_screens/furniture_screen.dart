import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/product/product_section.dart';

class FurnitureScreen extends StatelessWidget {
  const FurnitureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(headingText: "Furniture")
        ],
      ),
    );
  }
}
