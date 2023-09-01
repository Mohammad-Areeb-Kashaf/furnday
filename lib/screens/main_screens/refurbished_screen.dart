import 'package:furnday/constants.dart';

class RefurbishedScreen extends StatelessWidget {
  const RefurbishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(
            headingText: "Refurbished",
            productGridType: ProductGridType.refurbishedProducts,
          )
        ],
      ),
    );
  }
}
