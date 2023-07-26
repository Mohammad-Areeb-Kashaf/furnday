import 'package:furnday/constants.dart';

class HardwareScreen extends StatelessWidget {
  const HardwareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: kScrollPhysics,
      child: Column(
        children: [
          AutoSwipeAds(),
          ProductSection(
            headingText: "Hardware",
            productGridType: ProductGridType.hardwareProducts,
            productServicesInstance: ProductServices(),
          ),
        ],
      ),
    );
  }
}
