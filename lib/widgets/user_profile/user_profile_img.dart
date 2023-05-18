import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  UserProfileImage({super.key, required this.isAppBar});
  final bool isAppBar;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: isAppBar ? null : 50,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: _auth.currentUser!.photoURL != null
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      _auth.currentUser!.photoURL.toString(),
                    ),
                    fit: BoxFit.fill),
              ),
            )
          : isAppBar
              ? const Icon(Icons.person)
              : const Icon(
                  Icons.person,
                  size: 50,
                ),
    );
  }
}
