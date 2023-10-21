import 'package:furnday/constants.dart';
import 'package:furnday/controllers/shiprocket_services_controller.dart';

enum ScreenDeterminer {
  home,
  allProducts,
  categories,
  furniture,
  hardware,
  refurbished,
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
  late final user;
  late bool isEmailVerified;
  bool canResendEmail = false;
  Timer timer = Timer(Duration.zero, () {});
  late final CartController cartController;
  late final ProductsController productsController;
  late final ShiprocketServicesController shiprocketServicesController;
  late final userAddressController;
  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    productsController = Get.put(ProductsController());
    shiprocketServicesController = Get.put(ShiprocketServicesController());
    cartController = Get.put(CartController());
    userAddressController = Get.put(UserAddressController());
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
    }
    if (isUserSignedIn) {
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
    } else {
      setState(() {
        isEmailVerified = true;
      });
    }
  }

  Future checkEmailVerified() async {
    try {
      await _auth.currentUser!.reload();

      setState(() {
        isEmailVerified = _auth.currentUser!.emailVerified;
      });

      if (isEmailVerified) {
        await cartController.createCart();
        timer.cancel();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  void dispose() {
    timer.cancel();

    Get.delete<ProductsController>();
    Get.delete<CartController>();
    Get.delete<ShiprocketServicesController>();
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
      printError(info: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isEmailVerified
        ? InternetChecker(
            child: Scaffold(
              drawer: Drawer(
                backgroundColor: kWhiteBackground,
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
                      title: const AutoSizeText(
                        'Home',
                        maxFontSize: 20,
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
                      title: const AutoSizeText(
                        'All Products',
                        maxFontSize: 20,
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
                      title: const AutoSizeText(
                        'Categories',
                        maxFontSize: 20,
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
                      title: const AutoSizeText(
                        'Furniture',
                        maxFontSize: 20,
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
                      title: const AutoSizeText(
                        'Hardware',
                        maxFontSize: 20,
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
                      title: const AutoSizeText(
                        'Refurbished',
                        maxFontSize: 20,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const HireACarpenterScreen()));
                      },
                      title: const AutoSizeText(
                        'Hire a Carpenter',
                        maxFontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              appBar: myAppBar(context),
              body: screenDeterminer(),
            ),
          )
        : InternetChecker(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kYellowColor,
                          kOrangeColor,
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: kScrollPhysics,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: DecoratedCard(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        'Verify Email',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: Colors.black87,
                                            ),
                                        minFontSize: 24,
                                        maxFontSize: 32,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 8),
                                      AutoSizeText.rich(
                                        TextSpan(
                                          text:
                                              'A verification email has been sent to your email address\n',
                                          children: [
                                            TextSpan(
                                              text: _auth.currentUser!.email,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        minFontSize: 14,
                                        maxFontSize: 22,
                                        maxLines: 3,
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50),
                                        ),
                                        onPressed: canResendEmail
                                            ? sendVerificationEmail
                                            : null,
                                        icon: const Icon(
                                          Icons.email,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                        label: const Text(
                                          'Resent Email',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50),
                                        ),
                                        onPressed: () {
                                          _auth.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const SignInScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Cancel',
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
