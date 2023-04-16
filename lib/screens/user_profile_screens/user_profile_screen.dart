import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/user_profile_screens/my_orders_screen.dart';
import 'package:furnday/services/network_services.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser!.photoURL);
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          shape: const ContinuousRectangleBorder(),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          foregroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    yellowColor,
                    orangeColor,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: scrollPhysics,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const UserProfileScreen(),
                                ),
                              );
                            },
                            highlightColor: Theme.of(context).highlightColor,
                            child: Hero(
                              tag: "profile_img",
                              transitionOnUserGestures: true,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: _auth.currentUser!.photoURL != null
                                    ? CachedNetworkImage(
                                        imageUrl: _auth.currentUser!.photoURL
                                            .toString(),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${_auth.currentUser!.displayName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '${_auth.currentUser!.email}',
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 20),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: DecoratedCard(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const MyOrdersScreen())),
                                  title: const Text('My Orders'),
                                  leading: const Icon(Icons.shopping_bag),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                const ListTile(
                                  title: Text('Payment Methods'),
                                  leading: Icon(Icons.payment),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                                const ListTile(
                                  title: Text('Delivery Addresses'),
                                  leading: Icon(Icons.location_pin),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                                const ListTile(
                                  title: Text('My Favorites'),
                                  leading: Icon(Icons.favorite_outline),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                                const ListTile(
                                  title: Text('Settings'),
                                  leading: Icon(Icons.settings),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (_auth.currentUser!.providerData
                                          .contains("google")) {
                                        await GoogleSignIn().disconnect();
                                        await _auth.signOut();
                                      } else {
                                        await _auth.signOut();
                                      }
                                    } catch (e) {
                                      print(e);
                                      NetworkStatusService().checkInternet();
                                    }
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
