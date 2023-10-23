import 'package:furnday/constants.dart';

class UserAddressController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final user;
  String userUid = '';
  bool isUserSignedIn = false;
  Rx<UserAddressModel> shippingAddressModel = UserAddressModel().obs;
  Rx<UserAddressModel> billingAddressModel = UserAddressModel().obs;

  @override
  onInit() async {
    super.onInit();
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
      userUid = user.uid;
    }
    shippingAddressModel.value = await getShippingAddressModel();
    billingAddressModel.value = await getBillingAddressModel();
    print(shippingAddressModel.value.firstName);
  }

  getBillingAddressModel() async {
    try {
      if (isUserSignedIn) {
        var doc = await _firestore.collection("users").doc(userUid).get();
        UserAddressModel billingAddress =
            UserAddressModel.fromJson(doc.data()!['billingAddress']);
        return billingAddress;
      } else {
        return UserAddressModel();
      }
    } catch (e) {
      printError(info: e.toString());
      return UserAddressModel();
    }
  }

  getShippingAddressModel() async {
    try {
      if (isUserSignedIn) {
        print("fetching shipping address");
        var doc = await _firestore.collection("users").doc(userUid).get();
        UserAddressModel shippingAddress =
            UserAddressModel.fromJson(doc.data()!['shippingAddress']);
        print("shipping Address first name:${shippingAddress.firstName}");
        return shippingAddress;
      } else {
        print('else implementing');
        return UserAddressModel();
      }
    } catch (e) {
      print(e.toString());
      printError(info: e.toString());
      return UserAddressModel();
    }
  }

  setBillingAddress({required UserAddressModel userAddress}) async {
    if (isUserSignedIn) {
      var doc = _firestore.collection('users').doc(userUid);
      try {
        await doc.set(
            {"billingAddress": userAddress.toJson()}, SetOptions(merge: true));
        billingAddressModel.value = userAddress;
      } catch (e) {
        printError(info: e.toString());
      }
    }
  }

  setShippingAddress({required UserAddressModel userAddress}) async {
    if (isUserSignedIn) {
      var doc = _firestore.collection('users').doc(userUid);
      try {
        await doc.set(
            {"shippingAddress": userAddress.toJson()}, SetOptions(merge: true));
        shippingAddressModel.value = userAddress;
      } catch (e) {
        printError(info: e.toString());
      }
    }
  }

  Widget getBillingAddressCard() {
    return AddressCard(
      userAddress: billingAddressModel.value.firstName != null
          ? billingAddressModel.value
          : UserAddressModel(),
      isAddressNull: billingAddressModel.value.firstName != null ? false : true,
    );
  }

  Widget getShippingAddressCard() {
    return AddressCard(
      userAddress: shippingAddressModel.value,
      isAddressNull:
          shippingAddressModel.value.firstName != null ? false : true,
      isShipping: true,
    );
  }
}
