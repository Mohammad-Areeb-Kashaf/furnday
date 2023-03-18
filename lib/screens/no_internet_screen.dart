import 'package:flutter/material.dart';
import 'package:furnday/services/network_services.dart';
import 'package:furnday/widgets/my_appbar.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Internet!'),
            const Text(
              'Please check your internet connection and Try again',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                NetworkStatusService().checkInternet();
              },
              child: const Text('Retry'),
            )
          ],
        ),
      ),
    );
  }
}
