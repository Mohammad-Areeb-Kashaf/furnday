import 'package:flutter/material.dart';

AppBar myAppBar() {
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
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
      )
    ],
    title: Image.asset(
      "assets/images/Furnday-logo.png",
      fit: BoxFit.cover,
    ),
  );
}
