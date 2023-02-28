import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auto_swipe_ads.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/my_appbar.dart';
import 'package:furnday/widgets/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _listImage = [
    "",
    "https://www.furnday.com/wp-content/uploads/2022/11/Carpenter.jpg",
    "https://cdn.truelancer.com/upload-original/1677430198-Furnday-new-logo-(1).png",
    "https://cdn.truelancer.com/upload-original/1677430198-Furnday-new-logo-(4).png",
  ];

  final _gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: whiteBackground,
        child: ListView(
          children: const [
            ListTile(
              selected: true,
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'All Products',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Furniture',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Hardware',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Refurbished',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Hire a Carpenter',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: myAppBar(),
      body: SingleChildScrollView(
        physics: scrollPhysics,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            children: [
              AutoSwipeAds(
                listImage: _listImage,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: DecoratedCard(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 246, 195, 60),
                          borderRadius: BorderRadius.only(
                            topLeft: radius,
                            topRight: radius,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Popular',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          children: List.generate(
                            60,
                            (index) {
                              return const ProductCard();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
