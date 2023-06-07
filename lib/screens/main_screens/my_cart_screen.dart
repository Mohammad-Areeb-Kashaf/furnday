import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/providers/cart_provider.dart';
import 'package:furnday/services/user_services.dart';
import 'package:furnday/widgets/cart/my_cart_card.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  var shippingAddress;

  @override
  void initState() {
    super.initState();
    shippingAddress = UserServices().getShippingAddressCard();
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Consumer<CartProvider>(
        builder: (context, cartProviderModel, widget) {
          cartProviderModel.getCartItems();
          return Scaffold(
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
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        physics: kScrollPhysics,
                        itemCount: cartProviderModel.cartItems.length,
                        itemBuilder: (context, index) {
                          print(cartProviderModel.cartItems[index]);
                          return MyCartCard(
                              product: cartProviderModel.cartItems[index]);
                        },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Subtotal:",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "₹${cartProviderModel.cartSubtotal.toString()}",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  AutoSizeText(
                                    "Shipping:",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "Free shipping",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              shippingAddress!,
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Total:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "₹${cartProviderModel.cartTotal}",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
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
          );
        },
      ),
    );
  }
}
