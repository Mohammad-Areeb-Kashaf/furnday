import 'package:furnday/constants.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(
            headingText: "All Products",
            productGridType: ProductGridType.allProducts,
          )
        ],
      ),
    );
  }
}
