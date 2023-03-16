import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/all_products_screen.dart';
import 'package:furnday/screens/auth/signin_screen.dart';
import 'package:furnday/screens/categories_screen.dart';
import 'package:furnday/screens/furniture_screen.dart';
import 'package:furnday/screens/hardware_screen.dart';
import 'package:furnday/screens/hire_a_carpenter_screen.dart';
import 'package:furnday/screens/home_screen.dart';
import 'package:furnday/screens/refurbished_screen.dart';
import 'package:furnday/size_config.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/my_appbar.dart';

enum ScreenDeterminer {
  home,
  allProducts,
  categories,
  furniture,
  hardware,
  refurbished,
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var myScreen = ScreenDeterminer.home;
  bool homeSelected = true;
  bool allProductsSelected = false;
  bool categoriesSelected = false;
  bool furnitureSelected = false;
  bool hardwareSelected = false;
  bool refurbishedSelected = false;
  final _auth = FirebaseAuth.instance;
  late bool isEmailVerified;
  bool canResendEmail = false;
  Timer timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
    setState(() {
      isEmailVerified = _auth.currentUser!.emailVerified;
    });

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await _auth.currentUser!.reload();

    setState(() {
      isEmailVerified = _auth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = _auth.currentUser!;
      await user.sendEmailVerification();

      setState(
        () => canResendEmail = false,
      );
      await Future.delayed(const Duration(seconds: 5));
      setState(
        () => canResendEmail = true,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isEmailVerified
        ? InternetChecker(
            child: Scaffold(
              drawer: Drawer(
                backgroundColor: whiteBackground,
                child: ListView(
                  children: [
                    ListTile(
                      selected: homeSelected,
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.home,
                        );
                        setState(() {
                          homeSelected = true;
                        });
                      },
                      title: const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.allProducts,
                        );
                        setState(() {
                          allProductsSelected = true;
                        });
                      },
                      selected: allProductsSelected,
                      title: const Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.categories,
                        );
                        setState(() {
                          categoriesSelected = true;
                        });
                      },
                      selected: categoriesSelected,
                      title: const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.furniture,
                        );
                        setState(() {
                          furnitureSelected = true;
                        });
                      },
                      selected: furnitureSelected,
                      title: const Text(
                        'Furniture',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.hardware,
                        );
                        setState(() {
                          hardwareSelected = true;
                        });
                      },
                      selected: hardwareSelected,
                      title: const Text(
                        'Hardware',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        listTileSelected(
                          screenTile: ScreenDeterminer.refurbished,
                        );
                        setState(() {
                          refurbishedSelected = true;
                        });
                      },
                      selected: refurbishedSelected,
                      title: const Text(
                        'Refurbished',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HireACarpenterScreen()));
                      },
                      title: const Text(
                        'Hire a Carpenter',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              appBar: myAppBar(context),
              body: screenDeterminer(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Verify Email',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'A verification email has been sent to your email address',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      icon: const Icon(
                        Icons.email,
                        size: 32,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Resent Email',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  screenDeterminer() {
    switch (myScreen) {
      case ScreenDeterminer.allProducts:
        return const AllProductsScreen();
      case ScreenDeterminer.categories:
        return const CategoriesScreen();
      case ScreenDeterminer.furniture:
        return const FurnitureScreen();
      case ScreenDeterminer.hardware:
        return const HardwareScreen();
      case ScreenDeterminer.refurbished:
        return const RefurbishedScreen();
      default:
        return const HomeScreen();
    }
  }

  listTileSelected({screenTile}) {
    switch (myScreen) {
      case ScreenDeterminer.home:
        setState(() {
          myScreen = screenTile;
          homeSelected = false;
        });

        break;

      case ScreenDeterminer.allProducts:
        setState(() {
          myScreen = screenTile;
          allProductsSelected = false;
        });
        break;
      case ScreenDeterminer.categories:
        setState(() {
          myScreen = screenTile;
          categoriesSelected = false;
        });
        break;
      case ScreenDeterminer.furniture:
        setState(() {
          myScreen = screenTile;
          furnitureSelected = false;
        });
        break;
      case ScreenDeterminer.hardware:
        setState(() {
          myScreen = screenTile;
          hardwareSelected = false;
        });
        break;
      case ScreenDeterminer.refurbished:
        setState(() {
          myScreen = screenTile;
          refurbishedSelected = false;
        });
        break;
    }
  }
}
