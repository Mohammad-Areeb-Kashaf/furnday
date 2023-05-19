import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:furnday/screens/user_profile_screens/my_order_detail_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_img.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const MyOrderDetailScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DecoratedCard(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const ProductImg(
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          AutoSizeText(
                            'Bed',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 20,
                          ),
                          Spacer(),
                          AutoSizeText(
                            'Delivered',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 24,
                          ),
                        ],
                      ),
                      const AutoSizeText(
                        '#1234567890',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxFontSize: 20,
                      ),
                      Row(
                        children: const [
                          AutoSizeText(
                            'Deliver Date:',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 20,
                          ),
                          AutoSizeText(
                            '16/04/2023',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            maxFontSize: 22,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AutoSizeText(
                            'qty:',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 20,
                          ),
                          AutoSizeText(
                            '4',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            maxFontSize: 20,
                          ),
                          Spacer(),
                          AutoSizeText(
                            '₹99999',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
