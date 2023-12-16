import 'package:furnday/constants.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserAddressController>();
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Addresses',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: kScrollPhysics,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Column(
                  children: [
                    controller.getBillingAddressCard(),
                    const SizedBox(height: 8),
                    controller.getShippingAddressCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
