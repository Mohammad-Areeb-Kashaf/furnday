import 'package:flutter/material.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/user_profile/address_card.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Addresses',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  AddressCard(),
                  SizedBox(height: 8),
                  AddressCard(
                    isShipping: true,
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
