import 'package:furnday/constants.dart';

class CartController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final User? user;
  var cartItems = <CartModel>[].obs;
  bool isUserSignedIn = false;
  String userUid = '';

  int get cartItemsCount => cartItems.fold(
      0, (previousValue, element) => previousValue + element.qty!.toInt());

  double get totalPrice => cartItems.fold(
      0,
      (sum, item) =>
          sum +
          (int.parse(item.discountedPrice.toString()) *
              int.parse(item.qty.toString())));

  @override
  void onInit() async {
    super.onInit();
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
      userUid = user!.uid;
    }

    await getCartItems();
  }

  getCartItems() async {
    printInfo(info: "User is signedIN = $isUserSignedIn");
    if (isUserSignedIn) {
      await Future.delayed(const Duration(seconds: 1));
      if (isUserSignedIn && userUid.isNotEmpty) {
        _firestore
            .collection('users')
            .doc(userUid)
            .snapshots()
            .listen((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            var cartResponseData =
                documentSnapshot.data() as Map<String, dynamic>;
            final cartData = cartResponseData['cart'] as List<dynamic>;
            cartItems.assignAll(
              cartData.map((item) => CartModel.fromJson(item)).toList(),
            );

            groupCartItems();
          } else if (!documentSnapshot.exists) {
            await createCart();
          }
        }).onError((e) {
          printError(info: e.toString());
        });
      }
    }
  }

  void groupCartItems() {
    final Map<String, List<CartModel>> groupedItems = {};

    for (final cartItem in cartItems) {
      final key = '${cartItem.id}-${cartItem.customisations}';

      if (groupedItems.containsKey(key)) {
          groupedItems[key]!.first.qty =
              groupedItems[key]!.first.qty!.toInt() + cartItem.qty!.toInt();
        } else {
          groupedItems[key] = [cartItem];
        }
    }

    cartItems.clear();
    cartItems.assignAll(groupedItems.values.expand((items) => items));
  }

  void addToCart(CartModel newItem) {
    final existingIndex = cartItems.indexWhere((item) =>
        item.id == newItem.id && item.customisations == newItem.customisations);

    if (existingIndex != -1) {
      cartItems[existingIndex].qty =
          cartItems[existingIndex].qty!.toInt() + newItem.qty!.toInt();
    } else {
      cartItems.add(newItem);
    }

    updateCartInFirestore();
  }

  void updateCartModelqty(CartModel CartModel, int newqty) {
    final existingIndex = cartItems.indexWhere((item) =>
        item.id == CartModel.id &&
        item.customisations == CartModel.customisations);

    if (existingIndex != -1) {
      cartItems[existingIndex].qty = newqty;

      updateCartInFirestore();
    }
  }

  void removeCartModel(CartModel CartModel) {
    cartItems.removeWhere((item) =>
        item.id == CartModel.id &&
        item.customisations == CartModel.customisations);

    updateCartInFirestore();
  }

  Future<void> updateCartInFirestore() async {
    final cartData = cartItems.map((item) => item.toJson()).toList();
    await _firestore.collection('users').doc(userUid).update({
      'cart': cartData,
    });

    groupCartItems();
  }

  orderedAllCart() async {
    try {
      if (isUserSignedIn) {
        await _firestore.collection('users').doc(userUid).update({"cart": []});
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  createCart() async {
    try {
      if (isUserSignedIn) {
        var data = {"cart": [], "billingAddress": {}, "shippingAddress": {}};
        await _firestore.collection("users").doc(userUid).set(data);

        return true;
      }
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }

  void removeCartItem(CartModel cartItem) {
    cartItems.removeWhere((item) =>
        item.id == cartItem.id &&
        item.customisations == cartItem.customisations);
    updateCartInFirestore();
  }

  void updateCartItemQuantity(CartModel cartItem, int newQuantity) {
    final existingIndex = cartItems.indexWhere((item) =>
        item.id == cartItem.id &&
        item.customisations == cartItem.customisations);

    if (existingIndex != -1) {
      cartItems[existingIndex].qty = newQuantity;

      updateCartInFirestore();
    }
  }
}
