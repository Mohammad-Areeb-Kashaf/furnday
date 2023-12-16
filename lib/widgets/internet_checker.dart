import 'package:flutter/material.dart';
import 'package:furnday/screens/no_internet_screen.dart';
import 'package:furnday/widgets/network_aware_widget.dart';

class InternetChecker extends StatelessWidget {
  final Widget child;

  const InternetChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        onlineChild: child,
        offlineChild: const NoInternetScreen(),
      ),
    );
  }
}
