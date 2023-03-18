import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:furnday/screens/user_profile_screen.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => UserProfileScreen(),
              ),
            );
          },
          highlightColor: Theme.of(context).highlightColor,
          child: const Icon(Icons.person),
        ),
      )
    ],
    title: Image.asset(
      "assets/images/Furnday-logo.png",
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    ),
  );
}
