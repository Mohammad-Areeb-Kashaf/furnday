import 'package:furnday/constants.dart';

class MyCartCard extends StatefulWidget {
  const MyCartCard({
    super.key,
    required this.product,
    required this.productQuantityWidget,
    required this.removeCartItem,
    required this.customisations,
    this.cart,
  });
  final ProductModel product;
  final CartModel? cart;
  final Function productQuantityWidget;
  final Function removeCartItem;
  final List<String>? customisations;

  @override
  State<MyCartCard> createState() => _MyCartCardState();
}

class _MyCartCardState extends State<MyCartCard> {
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DecoratedCard(
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => widget.removeCartItem(widget.cart),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImg(
                    height: 100,
                    width: 100,
                    images: widget.product.productImages,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                widget.product.name.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 26,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AutoSizeText(
                                "₹${widget.product.discountedPrice}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 26,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: widget.productQuantityWidget(widget.cart),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
