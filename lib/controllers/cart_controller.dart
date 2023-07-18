import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/models/product/cart_model.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/widgets/loading_dialog.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var cartItems = <CartModel>[].obs;
  var productCartItems = <ProductModel>[].obs;
  var cart = {}.obs;
  var cartItemsCount = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCartItems();
    await getCartItemsCount();
  }

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
      getCartItemsCount();
    } catch (e) {
      print(e);
    }
  }

  addToCart(BuildContext context, CartModel cartItem) async {
    cartItems.add(cartItem);
    await updateCart(context);
    await getCartItems();
    await getCartItemsCount();
  }

  updateCart(BuildContext context) async {
    loadDialog(context);
    var cartProds = {};
    for (var cartItem in cartItems) {
      var cartItemJson = cartItem.toJson();
      cartProds.addAll({cartItem.id: cartItemJson});
    }
    await _firestore
        .collection('users')
        .doc(userUid)
        .update({"cart": cartProds});
    await getCartItems();
    await getCartItemsCount();
    Navigator.of(context).pop();
  }

  orderedAllCart() async {
    await _firestore.collection('users').doc(userUid).update({"cart": {}});
    getCartItems();
    getCartItemsCount();
  }

  getCartItemsCount() async {
    var itemCount = 0;
    for (var cartItem in cartItems) {
      itemCount += cartItem.qty!.toInt();
    }
    cartItemsCount.value = itemCount;
  }
}
