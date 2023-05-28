import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required this.productGridType});

  final ProductGridType productGridType;
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

  productGridTypeDeterminer() {
    switch (widget.productGridType) {
      case ProductGridType.allProducts:
        return ProductServices().getAllProducts(
          context,
          gridChildAspectRatio: gridChildAspectRatio,
          gridCrossAxisCount: gridCrossAxisCount,
        );
      case ProductGridType.featuredProducts:
        return ProductServices().getFeaturedProducts(
          context,
          gridChildAspectRatio: gridChildAspectRatio,
          gridCrossAxisCount: gridCrossAxisCount,
        );
      case ProductGridType.refurbishedProducts:
        return const Placeholder();
      case ProductGridType.furniture:
        return const Placeholder();
      case ProductGridType.hardware:
        return const Placeholder();
      case ProductGridType.plywood:
        return const Placeholder();
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      gridCrossAxisCount = gridCrossAxisCountDeterminer(context);
      gridChildAspectRatio = gridChildAspectRatioDeterminer();
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: productGridTypeDeterminer(),
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
          (MediaQuery.of(context).size.height / 1);
    } else {
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.25);
    }
  }
}
