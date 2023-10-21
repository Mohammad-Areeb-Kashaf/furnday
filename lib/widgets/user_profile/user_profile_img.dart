import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key, required this.isAppBar});

  final bool isAppBar;

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  final _auth = FirebaseAuth.instance;
  late final user;
  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: widget.isAppBar ? null : 50,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: isUserSignedIn
            ? _auth.currentUser!.photoURL != null
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
                : widget.isAppBar
                    ? const Icon(Icons.person)
                    : const Icon(
                        Icons.person,
                        size: 50,
                      )
            : widget.isAppBar
                ? const Icon(Icons.person)
                : const Icon(
                    Icons.person,
                    size: 50,
                  ));
  }
}
