import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/screens/auth/signin_screen.dart';
import 'package:furnday/widgets/internet_checker.dart';

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
              title: const Text('Sign Out'),
              onTap: () {
                try {
                  _auth.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
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
