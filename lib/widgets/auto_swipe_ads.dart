import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/hire_a_carpenter_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';

class AutoSwipeAds extends StatelessWidget {
  AutoSwipeAds({super.key});
  final List<String> _listImage = [
    "",
    "https://www.furnday.com/wp-content/uploads/2022/11/Carpenter.jpg",
    "https://cdn.truelancer.com/upload-original/1677430198-Furnday-new-logo-(1).png",
    "https://cdn.truelancer.com/upload-original/1677430198-Furnday-new-logo-(4).png",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: _listImage
          .map(
            (e) => ClipRRect(
              borderRadius: borderRadiusCard,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadiusCard,
                      side: const BorderSide(
                        color: yellowColor,
                      ),
                    ),
                    child: DecoratedCard(
                      child: e.toString() == ""
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const HireACarpenterScreen(),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: borderRadiusCard,
                                child: Image.asset(
                                  "assets/images/hire_carpenter.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: borderRadiusCard,
                              child: CachedNetworkImage(
                                imageUrl: e,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: true,
        enlargeFactor: 0.4,
        viewportFraction: 1,
      ),
    );
  }
}
