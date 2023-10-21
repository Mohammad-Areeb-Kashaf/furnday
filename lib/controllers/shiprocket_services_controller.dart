import 'package:furnday/constants.dart';
import 'package:http/http.dart' as http;

class DelhiveryServicesController extends GetxController {
  checkPinCodeAvailability() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Token api-token-key Pass Token as 'Token XXXXXXXXXXXXXXXXXX'",
    };

    final params = {
      'filter_codes': '443101',
    };

    final url =
        Uri.parse('https://staging-express.delhivery.com/c/api/pin-codes/json/')
            .replace(queryParameters: params);

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.get error: statusCode= $status');

    printInfo(info: res.body.toString());
  }
}
