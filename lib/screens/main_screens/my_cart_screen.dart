import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/cart/my_cart_card.dart';
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
          child: ListView(
            padding: const EdgeInsets.all(8),
            physics: kScrollPhysics,
            children: const [
              MyCartCard(),
            ],
          ),
        ),
      ),
    );
  }
}
