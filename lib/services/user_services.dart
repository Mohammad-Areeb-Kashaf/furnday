import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/models/user/user_address_model.dart';
import 'package:furnday/widgets/cart/my_cart_card.dart';
import 'package:furnday/widgets/user_profile/address_card.dart';

class UserServices {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  static var cartItemsList = [];

  getCartItems() {
    try {
      final cartItemsStream =
          _firestore.collection('users').doc(userUid).snapshots();

      return StreamBuilder(
        stream: cartItemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            List? cartItems = snapshot.data!.data()!['cart'];
            if (cartItems != null) {
              for (var element in cartItems) {
                cartItemsList.add(ProductModel.fromJson(element));
              }
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shrinkWrap: true,
                  physics: kScrollPhysics,
                  itemCount: cartItemsList.length,
                  itemBuilder: (context, index) {
                    return MyCartCard(product: cartItemsList[index]);
                  });
            } else {
              return const Text("No Items in your cart");
            }
          } else {
            return const Text('Something went wrong');
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  addToCart(ProductModel product) {
    try {} catch (e) {}
  }

  getBillingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel billingAddress =
          UserAddressModel.fromJson(doc.data()!['billingAddress']);
      return billingAddress;
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      await _firestore.collection("app").doc('errors').update(errorData);
    }
  }

  getShippingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel shippingAddress =
          UserAddressModel.fromJson(doc.data()!['shippingAddress']);
      return shippingAddress;
    } catch (e) {
      print(e);

      var errorData = {
        "errors": [e.toString()]
      };
      await _firestore.collection("app").doc('errors').update(errorData);
    }
  }

  setBillingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"billingAddress": userAddress.toJson()});
    } catch (e) {
      print(e);
      await doc.set({"billingAddress": userAddress.toJson()});
    }
  }

  setShippingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"shippingAddress": userAddress.toJson()});
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      await _firestore.collection("app").doc('errors').update(errorData);
      await doc.set({"shippingAddress": userAddress.toJson()});
    }
  }

  Widget getBillingAddressCard() {
    final billingAddressStream =
        _firestore.collection("users").doc(userUid).snapshots();

    return StreamBuilder(
      stream: billingAddressStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasData) {
          try {
            Map<String, dynamic> data =
                snapshot.data!.data()!['billingAddress'];

            if (data.isNotEmpty) {
              var userAddress = UserAddressModel.fromJson(
                  snapshot.data!.data()!['billingAddress']);

              return AddressCard(
                userAddress: userAddress,
              );
            } else {
              return AddressCard(
                userAddress: UserAddressModel(),
                isAddressNull: true,
              );
            }
          } catch (e) {
            var errorData = {
              "errors": [e.toString()]
            };
            _firestore.collection("app").doc('errors').update(errorData);
            return AddressCard(
              userAddress: UserAddressModel(),
              isAddressNull: true,
            );
          }
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }

  Widget getShippingAddressCard() {
    final shippingAddressStream =
        _firestore.collection('users').doc(userUid).snapshots();

    return StreamBuilder(
      stream: shippingAddressStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasData) {
          try {
            Map<String, dynamic> data =
                snapshot.data!.data()!['shippingAddress'];

            if (data.isNotEmpty) {
              var userAddress = UserAddressModel.fromJson(
                  snapshot.data!.data()!['shippingAddress']);

              return AddressCard(
                userAddress: userAddress,
                isShipping: true,
              );
            } else {
              return AddressCard(
                userAddress: UserAddressModel(),
                isAddressNull: true,
                isShipping: true,
              );
            }
          } catch (e) {
            var errorData = {
              "errors": [e.toString()]
            };
            _firestore.collection("app").doc('errors').update(errorData);
            return AddressCard(
              userAddress: UserAddressModel(),
              isAddressNull: true,
              isShipping: true,
            );
          }
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }
}
