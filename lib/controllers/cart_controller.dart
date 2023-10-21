import 'package:furnday/constants.dart';

class CartController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final user;
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
      userUid = user.uid;
    }

    await getCartItems();
  }

  getCartItems() async {
    printInfo(info: "User is signedIN = $isUserSignedIn");
    if (isUserSignedIn) {
      print('waiting to fetch data');
      await Future.delayed(const Duration(seconds: 1));
      if (isUserSignedIn && userUid.isNotEmpty) {
        print('fetching data');
        _firestore
            .collection('users')
            .doc(userUid)
            .snapshots()
            .listen((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            print("document exists");
            var cartResponseData =
                documentSnapshot.data() as Map<String, dynamic>;
            final cartData = cartResponseData['cart'] as List<dynamic>;

            // Process the list of cart items.
            cartItems.assignAll(
              cartData.map((item) => CartModel.fromJson(item)).toList(),
            );

            // Step 3: Group Cart Items
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

  // Step 3: Grouping Cart Items
  void groupCartItems() {
    if (isUserSignedIn) {
      final Map<String, List<CartModel>> groupedItems = {};

      for (final cartItem in cartItems) {
        final key = '${cartItem.id}-${cartItem.customisations!.join(',')}';

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
  }

  // Step 5: Create a Method to Update Cart Item Quantity in Firestore
  Future<void> updateCartItemQuantityInFirestore(
      CartModel cartItem, int newQuantity) async {
    if (isUserSignedIn) {
      final index = cartItems.indexWhere((item) =>
          item.id == cartItem.id &&
          const ListEquality()
              .equals(item.customisations, cartItem.customisations));
      if (index != -1) {
        cartItems[index].qty = newQuantity;
        final cartData = cartItems.map((item) => item.toJson()).toList();
        await _firestore.collection('users').doc(userUid).update({
          'cart': cartData,
        });
        // After updating the cart item in Firestore, re-group the cart items.
        groupCartItems();
      }
    }
  }

  void updateCartItemQuantity(CartModel cartItem, int newQuantity) async {
    final existingIndex = cartItems.indexWhere((item) =>
        item.id == cartItem.id &&
        const ListEquality()
            .equals(item.customisations, cartItem.customisations));

    if (existingIndex != -1) {
      cartItems[existingIndex].qty = newQuantity;

      // Update the cart data in Firestore.
      await updateCartInFirestore();
    }
  }

  @override
  void onClose() {
    // Dispose of Firestore subscription and perform any necessary cleanup.
    super.onClose();
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

  void addToCart(CartModel newItem) async {
    final existingIndex = cartItems.indexWhere((item) =>
        item.id == newItem.id &&
        const ListEquality()
            .equals(item.customisations, newItem.customisations));

    if (existingIndex != -1) {
      // If the item already exists, update its quantity.
      cartItems[existingIndex].qty =
          cartItems[existingIndex].qty!.toInt() + newItem.qty!.toInt();
    } else {
      // If it's a new item, add it to the cart.
      cartItems.add(newItem);
    }

    // Update the cart data in Firestore.
    await updateCartInFirestore();
  }

  // Update the cart data in Firestore after modifying the cart.
  Future<void> updateCartInFirestore() async {
    if (isUserSignedIn) {
      printInfo(info: "Updating to cart");
      final cartData = cartItems.map((item) => item.toJson()).toList();
      await _firestore.collection('users').doc(userUid).update({
        'cart': cartData,
      }).onError((error, stackTrace) async {
        await _firestore.collection('users').doc(userUid).set({
          'cart': cartData,
        });
      });
      // After updating the cart in Firestore, re-group the cart items.
      groupCartItems();
    }
  }

  void removeCartItem(CartModel cartItem) async {
    cartItems.removeWhere((item) =>
        item.id == cartItem.id &&
        const ListEquality()
            .equals(item.customisations, cartItem.customisations));

    // Update the cart data in Firestore to reflect the removal.
    await updateCartInFirestore();
  }
}
