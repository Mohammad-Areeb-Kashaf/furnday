import 'package:flutter/material.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/heading_section_text.dart';
import 'package:furnday/widgets/product_grid.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.headingText});
  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DecoratedCard(
        child: Column(
          children: [
            HeadingSectionText(
              headingText: headingText,
            ),
            const ProductGrid(),
          ],
        ),
      ),
    );
  }
}
