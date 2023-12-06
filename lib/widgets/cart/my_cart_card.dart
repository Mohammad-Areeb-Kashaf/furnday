import 'package:furnday/constants.dart';
import 'package:furnday/widgets/cart/cart_product_customisation_section.dart';

class MyCartCard extends StatefulWidget {
  const MyCartCard({
    super.key,
    required this.productQuantityWidget,
    required this.removeCartItem,
    required this.customisations,
    required this.cartItem,
  });

  final CartModel cartItem;
  final Function productQuantityWidget;
  final Function removeCartItem;
  final String? customisations;

  @override
  State<MyCartCard> createState() => _MyCartCardState();
}

class _MyCartCardState extends State<MyCartCard> {
  final cartController = Get.find<CartController>();
  final productsController = Get.find<ProductsController>();
  late final ProductModel product;

  @override
  void initState() {
    super.initState();
    product = productsController.allProductsList
        .firstWhere((productItem) => productItem.id == widget.cartItem.id);
  }

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
                    onPressed: () => widget.removeCartItem(widget.cartItem),
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
                    image: product.productImages![0],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  product.name.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 12,
                                  maxFontSize: 20,
                                  maxLines: 2,
                                ),
                              ),
                              AutoSizeText(
                                "₹${product.discountedPrice}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 12,
                                maxFontSize: 20,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child:
                                widget.productQuantityWidget(widget.cartItem),
                          ),
                          CartProductCustomisationSection(
                            customisations: widget.cartItem.customisations,
                          )
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
