import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          ProductServices().getCategories(),
        ],
      ),
    );
  }
}
