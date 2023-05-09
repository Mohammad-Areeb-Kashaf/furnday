import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/user_profile_screens/my_order_detail_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:furnday/widgets/decorated_card.dart';

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
                ClipRRect(
                  borderRadius: borderRadiusCard,
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AutoSizeText(
                            '#1234567890',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 20,
                          ),
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
                        '16/04/2023',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        maxFontSize: 22,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AutoSizeText(
                            '4 Items',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 20,
                          ),
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
                      const AutoSizeText(
                        "Bed x 4",
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                        maxFontSize: 20,
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
