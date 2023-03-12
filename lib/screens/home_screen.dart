import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/product/product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          children: [
            AutoSwipeAds(),
            const ProductSection(
              headingText: "Popular",
            ),
          ],
        ),
      ),
    );
  }
}
