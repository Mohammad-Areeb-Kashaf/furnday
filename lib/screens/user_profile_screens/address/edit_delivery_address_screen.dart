import 'package:flutter/material.dart';
import 'package:furnday/widgets/internet_checker.dart';

class EditDeliveryAddressScreen extends StatefulWidget {
  const EditDeliveryAddressScreen({super.key, required this.addressType});
  final String addressType;

  @override
  State<EditDeliveryAddressScreen> createState() =>
      _EditDeliveryAddressScreenState();
}

class _EditDeliveryAddressScreenState extends State<EditDeliveryAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return InternetChecker(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit ${widget.addressType} Address',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ));
  }
}
