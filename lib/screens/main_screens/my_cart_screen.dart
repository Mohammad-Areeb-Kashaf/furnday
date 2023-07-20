import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/controllers/cart_controller.dart';
import 'package:furnday/models/api/create_order_model.dart';
import 'package:furnday/services/cashfree_services.dart';
import 'package:furnday/services/user_services.dart';
import 'package:furnday/widgets/cart/my_cart_card.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:get/get.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  var shippingAddress;
  var cfPaymentGatewayService = CFPaymentGatewayService();
  late Future<CreateOrderModel> createOrderModel;
  String orderId = '';
  String paymentSessionId = '';
  CFEnvironment environment = CFEnvironment.SANDBOX;
  final cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    shippingAddress = UserServices().getShippingAddressCard();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: GetX<CartController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'My Cart',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        physics: kScrollPhysics,
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          return MyCartCard(
                            product: controller.productCartItems[index],
                            cart: controller.cartItems[index],
                          );
                        },
                      ),
                      DecoratedCard(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const AutoSizeText(
                                "Cart Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxFontSize: 24,
                              ),
                              const Divider(thickness: 2.0),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Subtotal:",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "₹${controller.totalPrice.toString()}",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 2,
                              ),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Shipping:",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "Free shipping",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              shippingAddress!,
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Total:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                  AutoSizeText(
                                    "₹${controller.totalPrice}",
                                    minFontSize: 18,
                                    maxFontSize: 22,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 2,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await CashfreeServices()
                                        .createOrder(controller.totalPrice)
                                        .then((value) {
                                      print('Order ID:- ${value.orderId}');
                                      orderId = value.orderId.toString();
                                      paymentSessionId =
                                          value.paymentSessionId.toString();
                                      pay();
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Text(
                                  'Proceed to Pay',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void verifyPayment(String orderId) {
    print("Verify Payment");
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  pay() async {
    try {
      var session = createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[];
      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#F6C33C")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .setPrimaryTextColor("#000000")
          .setButtonBackgroundColor("#F6C33C")
          .setBackgroundColor("#F6C33C")
          .setNavigationBarTextColor("#000000")
          .setSecondaryTextColor("#000000")
          .setButtonTextColor("#000000")
          .build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }
}
