import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/decorated_card.dart';

class AutoSwipeAds extends StatelessWidget {
  const AutoSwipeAds({super.key, required this.listImage});
  final List<String> listImage;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: listImage
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
                          ? ClipRRect(
                              borderRadius: borderRadiusCard,
                              child: Image.asset(
                                "assets/images/hire_carpenter.png",
                                fit: BoxFit.cover,
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
