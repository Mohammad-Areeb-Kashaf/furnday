import 'package:furnday/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kYellowColor,
                      kOrangeColor,
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: kScrollPhysics,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AutoSizeText(
                          'Sign in',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black87,
                                  ),
                          minFontSize: 24,
                          maxFontSize: 32,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'Login to your account',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black38,
                                  ),
                          minFontSize: 16,
                          maxFontSize: 22,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: DecoratedCard(
                            child: AuthForm(
                              formKey: formKey,
                              isSignIn: true,
                              onPressed: signIn,
                              signInWithGoogle: signInWithGoogle,
                              signInWithFacebook: signInWithFacebook,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Sign up Now!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.black87,
                                      ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            minFontSize: 16,
                            maxFontSize: 20,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn({
    required String name,
    required String email,
    required String password,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          formKey.currentState!.validate();
          formKey.currentState!.reset();
        },
      );
      context.mounted
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()))
          : null;
    } on FirebaseAuthException catch (e) {
      printError(info: e.toString());

      setState(() {
        AuthForm.authError = e.toString();
        formKey.currentState!.validate();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      final auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email', "https://mail.google.com"])
              .signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential);
        context.mounted
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen()))
            : null;

        setState(() {
          isLoading = false;
        });
        Get.showSnackbar(const GetSnackBar(
          title: "Sign In Success",
          message: "Sign in using Google is successfull",
          borderRadius: 20,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });

      NetworkStatusService().checkInternet();
      printError(info: e.toString());
      context.mounted
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()))
          : null;
      setState(() {
        isLoading = false;
      });
    }
  }

  signInWithFacebook() async {
    try {
      setState(() {
        isLoading = true;
      });
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        if (accessToken.token.isNotEmpty) {
          final OAuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          await _auth.signInWithCredential(credential);
          context.mounted
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()))
              : null;
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        printInfo(info: result.status.toString());
        printInfo(info: result.message.toString());
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      printError(info: e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}
