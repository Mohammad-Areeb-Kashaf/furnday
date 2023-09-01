import 'package:furnday/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSwipeAds(),
          const ProductSection(
            headingText: "All Products",
            productGridType: ProductGridType.allProducts,
          ),
          // ProductSection(
          //   headingText: "Featured Products",
          //   productGridType: ProductGridType.featuredProducts,
          //   productServicesInstance: ProductServices(),
          // ),
        ],
      ),
    );
  }
}
