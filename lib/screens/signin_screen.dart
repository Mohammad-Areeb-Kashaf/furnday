import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/decorated_card.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  yellowColor,
                  orangeColor,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Sign in',
                    style: productNameTextStyle.copyWith(
                      color: Colors.black87,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'Login to your account',
                    style: productNameTextStyle.copyWith(
                      color: Colors.black38,
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: DecoratedCard(
                      child: Container(
                        height: 500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
