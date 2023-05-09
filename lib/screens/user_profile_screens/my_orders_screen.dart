import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/my_order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'My Orders',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: const [
              MyOrderCard(),
            ],
          ),
        ),
      ),
    );
  }
}
