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
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: kScrollPhysics,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
    );
  }
}
