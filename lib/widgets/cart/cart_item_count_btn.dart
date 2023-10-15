import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/controllers/cart_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class CartItemCountBtn extends StatelessWidget {
  const CartItemCountBtn({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      builder: (controller) {
        return badges.Badge(
          position: badges.BadgePosition.custom(top: -5, end: 0),
          badgeContent: Center(
              child: AutoSizeText(
            controller.cartItemsCount.toString(),
            minFontSize: 8,
            maxFontSize: 9,
            maxLines: 1
          )),
          child: child,
        );
      },
    );
  }
}
