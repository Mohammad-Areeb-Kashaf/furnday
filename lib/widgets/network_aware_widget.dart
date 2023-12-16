import 'package:flutter/material.dart';
import 'package:furnday/services/network_services.dart';
import 'package:provider/provider.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget(
      {super.key, required this.onlineChild, required this.offlineChild});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(builder: (context, data, child) {
      return data == NetworkStatus.online ? onlineChild : offlineChild;
    });
  }
}
