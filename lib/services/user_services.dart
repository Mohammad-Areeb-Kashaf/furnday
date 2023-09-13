import 'package:furnday/constants.dart';

class UserServices {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  static var cartItemsList = [];

  getBillingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel billingAddress =
          UserAddressModel.fromJson(doc.data()!['billingAddress']);
      return billingAddress;
    } catch (e) {
      printError(info: e.toString());
    }
  }

  getShippingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel shippingAddress =
          UserAddressModel.fromJson(doc.data()!['shippingAddress']);
      return shippingAddress;
    } catch (e) {
      printError(info: e.toString());
    }
  }

  setBillingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"billingAddress": userAddress.toJson()});
    } catch (e) {
      printError(info: e.toString());
      await doc.set({"billingAddress": userAddress.toJson()});
    }
  }

  setShippingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"shippingAddress": userAddress.toJson()});
    } catch (e) {
      printError(info: e.toString());
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
          return const CircularProgressIndicator(
            color: kYellowColor,
          );
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
            printError(info: e.toString());
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
          return const CircularProgressIndicator(
            color: kYellowColor,
          );
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
            printError(info: e.toString());
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
