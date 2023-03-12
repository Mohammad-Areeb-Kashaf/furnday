import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        physics: const BouncingScrollPhysics(),
        crossAxisCount: gridCrossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        childAspectRatio: gridChildAspectRatio,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        children: List.generate(
          60,
          (index) {
            return ProductCard();
          },
        ),
      ),
    );
  }

  gridCrossAxisCountDeterminer(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 326.0 &&
        MediaQuery.of(context).size.height >= 702.0) {
      return 2;
    } else {
      return 1;
    }
  }

  gridChildAspectRatioDeterminer() {
    if (gridCrossAxisCount == 1) {
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.2);
    } else {
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.25);
    }
  }
}
