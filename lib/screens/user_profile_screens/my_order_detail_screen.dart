import 'package:flutter/material.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyOrderDetailScreen extends StatelessWidget {
  const MyOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Order Details',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
