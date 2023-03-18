import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: Text(_auth.currentUser!.displayName.toString()),
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                try {
                  if (_auth.currentUser!.providerData[0]
                      .toString()
                      .contains('google')) {
                    await GoogleSignIn().signOut();
                    await _auth.signOut();
                    Navigator.pop(context);
                  } else {
                    await _auth.signOut();
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
