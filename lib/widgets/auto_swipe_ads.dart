import 'package:furnday/constants.dart';

class AutoSwipeAds extends StatelessWidget {
  AutoSwipeAds({super.key});
  final List<String> _listImage = [];

  @override
  Widget build(BuildContext context) {
    List<String> listImage = [];
    listImage.add("");
    listImage.addAll(_listImage);
    return CarouselSlider(
      items: listImage
          .map(
            (imageUrl) => ClipRRect(
              borderRadius: kBorderRadiusCard,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: kBorderRadiusCard,
                      side: const BorderSide(
                        color: kYellowColor,
                      ),
                    ),
                    child: DecoratedCard(
                      child: imageUrl.toString() == ""
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HireACarpenterScreen(),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: kBorderRadiusCard,
                                child: Image.asset(
                                  "assets/images/hire_carpenter.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: kBorderRadiusCard,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                ),
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
