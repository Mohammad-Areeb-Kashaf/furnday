import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/services/product_services.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';
import 'package:furnday/helpers/grid_determiners.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({
    super.key,
    required this.productGridType,
    this.selectedCategory = '',
  });

  final String selectedCategory;
  final ProductGridType productGridType;
  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
  }

  productGridTypeDeterminer() {
    switch (widget.productGridType) {
      case ProductGridType.allProducts:
        return ProductServices().getAllProducts(
          context,
          gridCrossAxisCount: gridCrossAxisCount,
        );
      case ProductGridType.featuredProducts:
        return ProductServices().getFeaturedProducts(
          context,
          gridCrossAxisCount: gridCrossAxisCount,
        );
      case ProductGridType.refurbishedProducts:
        return ProductServices().getRefurbishedProducts(
          gridCrossAxisCount,
        );
      case ProductGridType.furnitureProducts:
        return ProductServices().getFurnitureProducts(
          gridCrossAxisCount,
        );
      case ProductGridType.hardwareProducts:
        return ProductServices().getHardwareProducts(
          gridCrossAxisCount,
        );
      case ProductGridType.selectedCategoryProducts:
        return ProductServices().getSelectedCategoryProducts(
          gridCrossAxisCount,
          widget.selectedCategory,
        );
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      gridCrossAxisCount = gridCrossAxisCountDeterminer(context);
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: productGridTypeDeterminer(),
    );
  }
}
