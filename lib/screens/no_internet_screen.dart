import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
            const AutoSizeText(
              'No Internet!',
              minFontSize: 14,
              maxFontSize: 24,
              maxLines: 1,
            ),
            const AutoSizeText(
              'Please check your internet connection and Try again',
              textAlign: TextAlign.center,
              minFontSize: 12,
              maxFontSize: 22,
              maxLines: 2,
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
