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
  late CartController cartController;
  bool isLoading = false;
  var indexCartItem;
  var _qty;

  @override
  void initState() {
    super.initState();
    shippingAddress = UserServices().getShippingAddressCard();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: LoadingOverlay(
        isLoading: isLoading,
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
                  physics: kScrollPhysics,
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
                              productQuantityWidget: _buildProductQuantity,
                              removeCartItem: (cart) => removeCartItem(cart),
                              cart: controller.cartItems[index],
                              customisations:
                                  controller.cartItems[index].customisations,
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
                                      setState(() {
                                        isLoading = true;
                                      });
                                      UserAddressModel? shippingAddressModel =
                                          await UserServices()
                                              .getShippingAddressModel();
                                      if (shippingAddressModel!.firstName !=
                                          null) {
                                        await CashfreeServices()
                                            .createOrder(controller.totalPrice)
                                            .then((value) async {
                                          setState(() {
                                            orderId = value.orderId.toString();
                                            paymentSessionId = value
                                                .paymentSessionId
                                                .toString();
                                          });
                                          await pay();
                                        });
                                      } else {
                                        Get.showSnackbar(const GetSnackBar(
                                          title: "Error",
                                          message:
                                              'Please add shipping address',
                                          borderRadius: 20,
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } catch (e) {
                                      printError(info: e.toString());
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
      ),
    );
  }

  void verifyPayment(String paymentOrderId) async {
    bool paymentVerified = await CashfreeServices().getOrder(orderId);
    if (paymentVerified) {
      Get.showSnackbar(const GetSnackBar(
        message: "Payment Successful!!!",
        borderRadius: 20,
        duration: Duration(seconds: 3),
      ));

      setState(() {
        isLoading = true;
      });
      await cartController.orderedAllCart();
      setState(() {
        isLoading = false;
      });
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "Payment unsuccessful",
        borderRadius: 20,
        duration: Duration(seconds: 3),
      ));
    }
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    printError(info: errorResponse.getMessage().toString());
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
      printError(info: e.message);
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
    } on CFException catch (e) {
      printError(info: e.message);
    }
  }

  Widget _buildProductQuantity(cart) {
    return GetX<CartController>(
      builder: (controller) {
        void valueChanged(
          int qty,
        ) async {
          setState(() {
            isLoading = true;
          });
          try {
            controller.cartItems[indexCartItem].qty = int.parse(qty.toString());
            await controller.updateCart();
          } catch (e) {
            printError(info: e.toString());
          }
          setState(() {
            isLoading = false;
          });
        }

        indexCartItem = controller.cartItems.indexOf(cart);
        _qty = cart!.qty!.toInt();

        return ProductQuantity(
          qty: _qty,
          valueChanged: valueChanged,
        );
      },
    );
  }

  void removeCartItem(cart) async {
    setState(() {
      isLoading = true;
    });
    cartController.cartItems.removeWhere((element) => element == cart);
    await cartController.updateCart();
    setState(() {
      isLoading = false;
    });
  }
}
