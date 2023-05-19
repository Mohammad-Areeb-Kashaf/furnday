import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/product/product_card.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var gridCrossAxisCount = 2;
  var gridChildAspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      gridCrossAxisCount = gridCrossAxisCountDeterminer(context);
      gridChildAspectRatio = gridChildAspectRatioDeterminer();
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GridView.count(
        physics: kScrollPhysics,
        crossAxisCount: gridCrossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        childAspectRatio: gridChildAspectRatio,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        children: List.generate(
          60,
          (index) {
            return const ProductCard();
          },
        ),
      ),
    );
  }

  gridCrossAxisCountDeterminer(BuildContext context) {
    if (MediaQuery.of(context).size.height > 1100.0 ||
        MediaQuery.of(context).size.width > 800.0) {
      return 3;
    } else if (MediaQuery.of(context).size.width > 300.0 ||
        MediaQuery.of(context).size.height > 700.0) {
      return 2;
    } else {
      return 1;
    }
  }

  gridChildAspectRatioDeterminer() {
    if (gridCrossAxisCount == 3) {
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 0.8);
    } else {
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.25);
    }
  }
}
