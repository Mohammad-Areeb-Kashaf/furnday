import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/models/product/cart_model.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var cartItems = <CartModel>[].obs;
  var productCartItems = <ProductModel>[].obs;
  var cart = {}.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCartItems();
  }

  int get cartItemsCount => cartItems.fold(
      0, (previousValue, element) => previousValue + element.qty!.toInt());

  double get totalPrice => cartItems.fold(
      0,
      (sum, item) =>
          sum +
          (int.parse(item.discountedPrice.toString()) *
              int.parse(item.qty.toString())));

  getCartItems() async {
    try {
      cartItems.value = [];
      productCartItems.value = [];
      var userCart = await _firestore.collection('users').doc(userUid).get();
      cart.value = userCart.data()!['cart'];
      cart.forEach(
        (key, value) async {
          var cartItem = CartModel.fromJson(value);
          var productData = await _firestore
              .collection('all_products')
              .doc(key.toString().trim())
              .get();
          var data = productData.data() as Map<String, dynamic>;
          var productItem = ProductModel.fromJson(data);
          cartItems.add(cartItem);
          productCartItems.add(productItem);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  addToCart(BuildContext context,
      {required CartModel productCartItem, required int qty}) async {
    if (cartItems.any((element) => element.id == productCartItem.id)) {
      print("requirement satisfied");
      var cartItemIndex =
          cartItems.indexWhere((element) => element.id == productCartItem.id);
      var cartItemQty = cartItems[cartItemIndex].qty! + qty;
      print(cartItemQty);
      cartItems[cartItemIndex].qty = cartItemQty;
      await updateCart();
    } else {
      print('requirement not satisfied');
      productCartItem.qty = (productCartItem.qty! + qty);
      print(productCartItem.qty);
      cartItems.add(productCartItem);
      await updateCart();
    }
  }

  updateCart() async {
    var cartProds = {};
    for (var cartItem in cartItems) {
      var cartItemJson = cartItem.toJson();
      cartProds.addAll({cartItem.id: cartItemJson});
    }
    await _firestore
        .collection('users')
        .doc(userUid)
        .update({"cart": cartProds});
    getCartItems();
  }

  orderedAllCart() async {
    await _firestore.collection('users').doc(userUid).update({"cart": {}});
    getCartItems();
  }
}
