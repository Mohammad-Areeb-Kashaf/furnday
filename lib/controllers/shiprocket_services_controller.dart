import 'package:furnday/constants.dart';
import 'package:http/http.dart' as http;

class ShiprocketServicesController extends GetxController {
  String token = '';

  @override
  onInit() {
    super.onInit();
    // generateToken();
  }

  // generateToken() async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request('POST',
  //       Uri.parse('https://apiv2.shiprocket.in/v1/external/auth/login'));
  //   request.body = json.encode(
  //       {"email": "akgamer7666@gmail.com", "password": "areebakgamer786"});
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     token = json.decode(await response.stream.bytesToString())['token'];
  //     printInfo(info: "This is the Token: $token");
  //   } else {
  //     printError(info: response.reasonPhrase.toString());
  //   }
  // }

  createCustomOrder() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer {{token}}'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders/create/adhoc'));
    request.body = json.encode({
      "order_id": "224-447",
      "order_date": "2019-07-24 11:11",
      "pickup_location": "Jammu",
      "channel_id": "",
      "comment": "Reseller: M/s Goku",
      "billing_customer_name": "Naruto",
      "billing_last_name": "Uzumaki",
      "billing_address": "House 221B, Leaf Village",
      "billing_address_2": "Near Hokage House",
      "billing_city": "New Delhi",
      "billing_pincode": "110002",
      "billing_state": "Delhi",
      "billing_country": "India",
      "billing_email": "naruto@uzumaki.com",
      "billing_phone": "9876543210",
      "shipping_is_billing": true,
      "shipping_customer_name": "",
      "shipping_last_name": "",
      "shipping_address": "",
      "shipping_address_2": "",
      "shipping_city": "",
      "shipping_pincode": "",
      "shipping_country": "",
      "shipping_state": "",
      "shipping_email": "",
      "shipping_phone": "",
      "order_items": [
        {
          "name": "Bed",
          "sku": "chakra123",
          "units": 10,
          "selling_price": "900",
          "discount": "",
          "tax": "",
          "hsn": 441122
        }
      ],
      "payment_method": "Prepaid",
      "shipping_charges": 0,
      "giftwrap_charges": 0,
      "transaction_charges": 0,
      "total_discount": 0,
      "sub_total": 9000,
      "length": 10,
      "breadth": 15,
      "height": 20,
      "weight": 2.5
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
