import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:furnday/screens/main_screens/my_cart_screen.dart';
import 'package:furnday/screens/user_profile_screens/user_profile_screen.dart';
import 'package:furnday/widgets/cart/cart_item_count_btn.dart';
import 'package:furnday/widgets/user_profile/user_profile_img.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: CartItemCountBtn(
          child: IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const MyCartScreen(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const UserProfileScreen(),
            ),
          );
        },
        child: Hero(
          tag: "profile_img",
          transitionOnUserGestures: true,
          child: UserProfileImage(
            isAppBar: true,
          ),
        ),
      ),
    ],
    title: Image.asset(
      "assets/images/Furnday-logo.png",
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    ),
  );
}
