import 'package:flutter/material.dart';
import 'package:furnday/widgets/my_order/my_order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              MyOrderCard(),
            ],
          ),
        ),
    );
  }
}
