import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_img.dart';
import 'package:furnday/widgets/product/product_quantity.dart';

class MyCartCard extends StatelessWidget {
  const MyCartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DecoratedCard(
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductImg(
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              AutoSizeText(
                                'Bed',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 26,
                              ),
                              Spacer(),
                              AutoSizeText(
                                '₹14000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 26,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: ProductQuantity(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
