import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/controllers/cart_controller.dart';
import 'package:furnday/models/product/cart_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductQuantity extends StatefulWidget {
  ProductQuantity({super.key, this.cart});

  CartModel? cart;

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
  final int _tagIndex = 0;
  final cartController = Get.find<CartController>();
  late final indexCartItem;

  @override
  void initState() {
    super.initState();
    indexCartItem = cartController.cartItems.indexOf(widget.cart);
    _qty = widget.cart!.qty!.toInt();
  }

  void valueChanged() async {
    cartController.cartItems[indexCartItem].qty = _qty;
    await cartController.updateCart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: kBorderRadiusCard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (_qty > 1) {
                setState(() {
                  _qty--;
                });
                valueChanged();
              }
            },
            child: Icon(
              Icons.remove,
              size: 32,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          AutoSizeText(
            formatter.format(_qty),
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            maxFontSize: 18,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _qty++;
              });
              valueChanged();
            },
            child: Icon(
              Icons.add,
              size: 32,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
