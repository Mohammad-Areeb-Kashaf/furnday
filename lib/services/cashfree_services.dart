import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnday/models/api/create_order_model.dart';
import 'package:furnday/models/user/user_address_model.dart';
import 'package:furnday/services/user_services.dart';
import 'package:http/http.dart' as http;

class CashfreeServices {
  final _auth = FirebaseAuth.instance;

  createOrder(orderAmount) async {
    try {
      UserAddressModel shippingAddressModel =
          await UserServices().getShippingAddressModel();
      Map<String, dynamic>? queryParameters = {
        "order_amount": orderAmount.toString(),
        "customer_id": _auth.currentUser!.uid,
        "customer_name":
            "${shippingAddressModel.firstName} ${shippingAddressModel.lastName}",
        "customer_email": _auth.currentUser!.email.toString(),
        "customer_phone": shippingAddressModel.phoneNumber.toString(),
      };
      var uri = Uri.http(
          "areebkashaf.pythonanywhere.com", "/createOrder", queryParameters);
      var response = await http.post(uri);
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        var createOrderModel = CreateOrderModel.fromJson(jsonBody);
        return createOrderModel;
      } else {
        print(response.body);
        print(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}