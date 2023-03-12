import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class DecoratedCard extends StatelessWidget {
  DecoratedCard({
    super.key,
    required this.child,
  });

  final child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadiusCard,
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: whiteBackground,
          borderRadius: borderRadiusCard,
          border: Border.all(
            color: yellowColor,
          ),
        ),
        child: child,
      ),
    );
  }
}
