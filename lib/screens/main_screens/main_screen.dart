import 'package:furnday/constants.dart';
import 'package:furnday/widgets/main_screen/main_email_not_verified_child.dart';
import 'package:furnday/widgets/main_screen/main_email_verified_child.dart';

enum ScreenDeterminer {
  home,
  allProducts,
  categories,
  furniture,
  hardware,
  refurbished,
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  late final user;
  late bool isEmailVerified;
  bool canResendEmail = false;
  Timer timer = Timer(Duration.zero, () {});
  late final CartController cartController;
  late final ProductsController productsController;
  late final ShiprocketServicesController shiprocketServicesController;
  late final UserAddressController userAddressController;
  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    userAddressController = Get.put(UserAddressController());
    productsController = Get.put(ProductsController());
    shiprocketServicesController = Get.put(ShiprocketServicesController());
    cartController = Get.put(CartController());
    user = _auth.currentUser;
    if (user != null) {
      isUserSignedIn = true;
    }
    if (isUserSignedIn) {
      setState(() {
        isEmailVerified = _auth.currentUser!.emailVerified;
      });

      if (!isEmailVerified) {
        sendVerificationEmail();

        timer = Timer.periodic(
          const Duration(seconds: 3),
          (_) => checkEmailVerified(),
        );
      }
    } else {
      setState(() {
        isEmailVerified = true;
      });
    }
  }

  Future checkEmailVerified() async {
    try {
      await _auth.currentUser!.reload();

      setState(() {
        isEmailVerified = _auth.currentUser!.emailVerified;
      });

      if (isEmailVerified) {
        await cartController.createCart();
        timer.cancel();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  void dispose() {
    timer.cancel();

    Get.delete<ProductsController>();
    Get.delete<CartController>();
    Get.delete<ShiprocketServicesController>();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = _auth.currentUser!;
      await user.sendEmailVerification();

      setState(
        () => canResendEmail = false,
      );
      await Future.delayed(const Duration(seconds: 5));
      setState(
        () => canResendEmail = true,
      );
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isEmailVerified
        ? const MainEmailVerifiedChild()
        : MainEmailNotVerifiedChild(
            canResendEmail: canResendEmail,
            sendVerificationEmail: () => sendVerificationEmail(),
          );
  }
}
