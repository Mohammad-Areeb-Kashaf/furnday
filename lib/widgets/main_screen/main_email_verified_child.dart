import 'package:furnday/constants.dart';

class MainEmailVerifiedChild extends StatefulWidget {
  const MainEmailVerifiedChild({super.key});

  @override
  State<MainEmailVerifiedChild> createState() => _MainEmailVerifiedChildState();
}

class _MainEmailVerifiedChildState extends State<MainEmailVerifiedChild> {
  var myScreen = ScreenDeterminer.home;
  bool homeSelected = true;
  bool allProductsSelected = false;
  bool categoriesSelected = false;
  bool furnitureSelected = false;
  bool hardwareSelected = false;
  bool refurbishedSelected = false;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
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
                      MaterialPageRoute(
                          builder: (context) => const HireACarpenterScreen()));
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
