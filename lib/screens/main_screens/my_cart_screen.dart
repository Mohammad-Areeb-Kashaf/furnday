import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/cart/my_cart_card.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    physics: kScrollPhysics,
                    children: const [
                      MyCartCard(),
                      MyCartCard(),
                      MyCartCard(),
                    ],
                  ),
                  DecoratedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AutoSizeText(
                            "Cart Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 20,
                            maxFontSize: 24,
                          ),
                          const Divider(thickness: 2.0),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              AutoSizeText(
                                "Subtotal:",
                                minFontSize: 18,
                                maxFontSize: 22,
                              ),
                              AutoSizeText(
                                "₹14000",
                                minFontSize: 18,
                                maxFontSize: 22,
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "Shipping:",
                                minFontSize: 18,
                                maxFontSize: 22,
                              ),
                              Column(
                                children: [
                                  const AutoSizeText(
                                    "Free shipping",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  const Flexible(
                                    child: AutoSizeText.rich(
                                      TextSpan(
                                        text: "Shipping to ",
                                        children: [
                                          TextSpan(
                                            text:
                                                "XYZ Apartment, street, Mumbai 400001, Maharashtra",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      wrapWords: true,
                                      minFontSize: 16,
                                      maxFontSize: 20,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("Change address"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              AutoSizeText(
                                "Total:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 18,
                                maxFontSize: 22,
                              ),
                              AutoSizeText(
                                "₹14000",
                                minFontSize: 18,
                                maxFontSize: 22,
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 2,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
