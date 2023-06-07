import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/models/product/product_model.dart';

class CartProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  List<ProductModel> cartItems = [];
  int cartItemsCount = 0;
  int cartSubtotal = 0;
  int cartTotal = 0;

  getCartItems() async {
    var userCart = await _firestore.collection('users').doc(userUid).get();
    List? cart = userCart.data()!['cart'];
    try {
      List<ProductModel> cartItemsData = [];
      int cartPrice = 0;
      for (var index in cart!) {
        print(index);
        var productData = await _firestore
            .collection('all_products')
            .doc(index.toString().trim())
            .get();
        var data = productData.data() as Map<String, dynamic>;
        var product = ProductModel.fromJson(data);
        cartPrice += int.parse(product.discountedPrice.toString());
        cartItemsData.add(product);
      }
      if (cartItems != cartItemsData) {
        cartItems = cartItemsData;
        cartItemsCount = cartItems.length;
        cartSubtotal = cartPrice;
        cartTotal = cartPrice;
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
  }

  addToCartItem(ProductModel product) async {}
}
