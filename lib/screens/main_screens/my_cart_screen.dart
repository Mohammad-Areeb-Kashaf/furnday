import 'package:furnday/constants.dart';
import 'package:furnday/services/auth_services.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final _auth = FirebaseAuth.instance;
  late final user;
  Widget? shippingAddress;
  var cfPaymentGatewayService = CFPaymentGatewayService();
  late Future<CreateOrderModel> createOrderModel;
  String orderId = '';
  String paymentSessionId = '';
  CFEnvironment environment = CFEnvironment.SANDBOX;
  late CartController cartController;
  late bool isUserSignedIn;
  bool isLoading = false;
  var indexCartItem;
  var _qty;
  final userAddressController = Get.find<UserAddressController>();
  var shippingAddressModel;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
    }

    shippingAddress = userAddressController.getShippingAddressCard();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Obx(
          () {
            cartController = Get.find<CartController>();

            return AuthServices(
              isNotAuthenticatedChild: Scaffold(
                appBar: myAppBar(context),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You are not Signed in, please sign in'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()));
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              isAuthenticatedChild: Scaffold(
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
                          isUserSignedIn
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: kScrollPhysics,
                                  itemCount: cartController.cartItems.length,
                                  itemBuilder: (context, index) {
                                    final cartItem =
                                        cartController.cartItems[index];
                                    return MyCartCard(
                                      productQuantityWidget:
                                          _buildProductQuantity,
                                      removeCartItem: (cart) =>
                                          removeCartItem(cart),
                                      cartItem: cartItem,
                                      customisations: cartItem.customisations,
                                    ); // Use your custom cart item widget
                                  },
                                )
                              : const SizedBox.shrink(),
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
                                    maxLines: 1,
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
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        "₹${cartController.totalPrice.toString()}",
                                        minFontSize: 18,
                                        maxFontSize: 22,
                                        maxLines: 1,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        "Shipping:",
                                        minFontSize: 18,
                                        maxFontSize: 22,
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        "Free shipping",
                                        minFontSize: 18,
                                        maxFontSize: 22,
                                        maxLines: 1,
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
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(
                                        "₹${cartController.totalPrice}",
                                        minFontSize: 18,
                                        maxFontSize: 22,
                                        maxLines: 1,
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

                                        if (shippingAddressModel.firstName !=
                                                null &&
                                            cartController
                                                .cartItems.isNotEmpty) {
                                          await CashfreeServices()
                                              .createOrder(
                                                  cartController.totalPrice)
                                              .then((value) async {
                                            setState(() {
                                              orderId =
                                                  value.orderId.toString();
                                              paymentSessionId = value
                                                  .paymentSessionId
                                                  .toString();
                                            });
                                            await pay().catchError((error) {
                                              if (error ==
                                                  "phone : should be"
                                                      " a valid 10 digit indian phone number. example 9090407368. Value received: 1234567890") {
                                                Get.showSnackbar(
                                                    const GetSnackBar(
                                                  title: "Error",
                                                  message: "Pho"
                                                      "ne "
                                                      "number should be a valid 10 digit Indian phone number",
                                                ));
                                              }
                                            });
                                          });
                                        } else if (shippingAddressModel
                                            .firstName!.isEmpty) {
                                          Get.showSnackbar(const GetSnackBar(
                                            title: "Error",
                                            message:
                                                'Please add shipping address',
                                            borderRadius: 20,
                                            duration: Duration(seconds: 3),
                                          ));
                                        } else {
                                          Get.showSnackbar(const GetSnackBar(
                                            title: "Error",
                                            message:
                                                'There is nothing in your cart',
                                            borderRadius: 20,
                                            duration: Duration(seconds: 10),
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
            controller.updateCartItemQuantity(
                controller.cartItems[indexCartItem], qty);
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

  void removeCartItem(CartModel cartItem) async {
    setState(() {
      isLoading = true;
    });
    cartController.removeCartItem(cartItem);
    setState(() {
      isLoading = false;
    });
  }
}
