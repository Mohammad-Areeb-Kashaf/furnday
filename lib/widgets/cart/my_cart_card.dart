import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/controllers/cart_controller.dart';
import 'package:furnday/models/product/cart_model.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/product/product_img.dart';
import 'package:furnday/widgets/product/product_quantity.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyCartCard extends StatelessWidget {
  MyCartCard({
    super.key,
    required this.product,
    this.cart,
  });
  final ProductModel product;
  final CartModel? cart;
  final cartController = Get.find<CartController>();
  var indexCartItem;
  int _qty = 1;

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
                    onPressed: () async {
                      cartController.cartItems
                          .removeWhere((element) => element == cart);
                      cartController.updateCart();
                    },
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
                    images: product.productImages,
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
                            children: [
                              AutoSizeText(
                                product.name.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 26,
                              ),
                              const Spacer(),
                              AutoSizeText(
                                product.discountedPrice.toString(),
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
                            child: _buildProductQuantity(),
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

  Widget _buildProductQuantity() {
    return GetX<CartController>(
      builder: (controller) {
        void valueChanged(
          BuildContext context,
          int qty,
        ) async {
          try {
            context.loaderOverlay.show();
            controller.cartItems[indexCartItem].qty = qty;
            await controller.updateCart().then((value) {
              context.loaderOverlay.hide();
            });
          } catch (e) {
            print(e);
          }
        }

        indexCartItem = controller.cartItems.indexOf(cart);
        _qty = cart!.qty!.toInt();

        return ProductQuantity(
          qty: _qty,
          valueChanged: valueChanged,
        );
      },
    );
  }
}
