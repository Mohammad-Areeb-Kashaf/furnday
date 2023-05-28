import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';
import 'package:furnday/widgets/product/product_section.dart';

class HardwareScreen extends StatelessWidget {
  const HardwareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(
            headingText: "Hardware",
            productGridType: ProductGridType.hardware,
          ),
        ],
      ),
    );
  }
}
