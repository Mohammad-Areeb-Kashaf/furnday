import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:furnday/screens/user_profile_screens/user_profile_screen.dart';

AppBar myAppBar(BuildContext context) {
  final auth = FirebaseAuth.instance;

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
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: auth.currentUser!.photoURL != null
                ? CachedNetworkImage(
                    imageUrl: auth.currentUser!.photoURL.toString(),
                  )
                : const Icon(
                    Icons.person,
                  ),
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
