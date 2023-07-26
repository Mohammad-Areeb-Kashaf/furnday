import 'package:furnday/constants.dart';

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
  CartController cartController = CartController();

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
          cartController = controller;
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
                                    context.loaderOverlay.show();
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
                                    context.loaderOverlay.hide();
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

  void verifyPayment(String paymentOrderId) async {
    bool paymentVerified = await CashfreeServices().getOrder(orderId);
    if (paymentVerified) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Payment Successful!!!',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      context.loaderOverlay.show();
      await cartController
          .orderedAllCart()
          .then((value) => context.loaderOverlay.hide());
    } else {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(
            content: Center(
              child: Text('Payment Unsuccessful',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        );
    }
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

  Future pay() async {
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
      context.loaderOverlay.hide();
    } on CFException catch (e) {
      context.loaderOverlay.hide();
      print(e.message);
    }
  }
}
