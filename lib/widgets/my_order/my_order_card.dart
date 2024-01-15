import 'package:furnday/constants.dart';
import 'package:furnday/screens/user_profile_screens/my_orders/my_order_detail_screen.dart';

class MyOrderCard extends StatelessWidget {
  MyOrderCard({
    super.key,
  });
  final productController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyOrderDetailScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DecoratedCard(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ProductImg(
                  image: productController.allProductsList[0].productImages![0],
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            'Comfortable Bed',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 14,
                            maxFontSize: 20,
                            maxLines: 2,
                          ),
                          Spacer(),
                          AutoSizeText(
                            'Delivered',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 14,
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      AutoSizeText(
                        '#1234567890',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 14,
                        maxFontSize: 20,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            'Deliver Date:',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 14,
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            '16/04/2023',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            minFontSize: 14,
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'qty:',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            minFontSize: 14,
                            maxFontSize: 20,
                          ),
                          AutoSizeText(
                            '4',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            minFontSize: 14,
                            maxFontSize: 20,
                          ),
                          Spacer(),
                          AutoSizeText(
                            '₹99999',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 14,
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
