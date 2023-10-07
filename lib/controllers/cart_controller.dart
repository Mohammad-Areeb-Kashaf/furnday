import 'package:furnday/constants.dart';

class CartController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var cartItems = <CartModel>[].obs;
  var productCartItems = <ProductModel>[].obs;
  var cart = {}.obs;

  @override
  void onInit() async {
    await getCartItems();
    super.onInit();
  }

  int get cartItemsCount => cartItems.fold(
      0, (previousValue, element) => previousValue + element.qty!.toInt());

  double get totalPrice => cartItems.fold(
      0,
      (sum, item) =>
          sum +
          (int.parse(item.discountedPrice.toString()) *
              int.parse(item.qty.toString())));

  Future<bool> getCartItems() async {
    if (userUid.isNotEmpty) {
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
        return true;
      } catch (e) {
        printError(info: e.toString());
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addToCart(
      {required CartModel productCartItem, required int qty}) async {
    try {
      if (cartItems.any((element) => element.id == productCartItem.id)) {
        var cartItemIndex =
            cartItems.indexWhere((element) => element.id == productCartItem
                .id);
        var cartItemQty = cartItems[cartItemIndex].qty! + qty;
        cartItems[cartItemIndex].qty = cartItemQty;
        await updateCart();
      } else {
        productCartItem.qty = (productCartItem.qty! + qty);
        cartItems.add(productCartItem);
        await updateCart();
      }
      return true;
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }

  Future<bool> updateCart() async {
    try {
      var cartProds = {};
      for (var cartItem in cartItems) {
        var cartItemJson = cartItem.toJson();
        cartProds.addAll({cartItem.id: cartItemJson});
      }
      cartItems.value = [];
      await _firestore
          .collection('users')
          .doc(userUid)
          .update({"cart": cartProds});

      await getCartItems();
      return true;
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }

  Future<bool> orderedAllCart() async {
    try {
      await _firestore.collection('users').doc(userUid).update({"cart": {}});
      await getCartItems();
      return true;
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }

  createCart() async {
    try {
      var data = {"cart": {}, "billingAddres": {}, "shippingAddress": {}};
      await _firestore.collection("users").doc(userUid).set(data);
      await getCartItems();
      return true;
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }
}
