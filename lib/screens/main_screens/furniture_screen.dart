import 'package:furnday/constants.dart';

class FurnitureScreen extends StatelessWidget {
  const FurnitureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          const ProductSection(
            headingText: "Furniture",
            productGridType: ProductGridType.furnitureProducts,
          )
        ],
      ),
    );
  }
}
