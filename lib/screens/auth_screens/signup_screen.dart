import 'package:furnday/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                          'Sign up',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black87,
                                  ),
                          minFontSize: 24,
                          maxFontSize: 32,
                        ),
                        AutoSizeText(
                          'Create a new account',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black38,
                                  ),
                          minFontSize: 16,
                          maxFontSize: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: DecoratedCard(
                            child: AuthForm(
                              formkey: formKey,
                              isSignIn: false,
                              onPressed: signUp,
                              signInWithGoogle: signInWithGoogle,
                              signInWithFacebook: signInWithFacebook,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                  text: "Sign in Now!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await _auth.currentUser!.updateDisplayName(name);
        formKey.currentState!.validate();
        formKey.currentState!.reset();
        await _auth.currentUser!.reload();
        if (context.mounted) Navigator.pop(context);
      });
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
          await GoogleSignIn(scopes: ['email']).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      NetworkStatusService().checkInternet();
      printError(info: e.toString());
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
          printInfo(info: _auth.currentUser!.email.toString());
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

  signInWithTwitter() async {
    try {
      setState(() {
        isLoading = true;
      });
      // https://furnday-15bd6.firebaseapp.com/__/auth/handler

      final twitterLogin = TwitterLogin(
          apiKey: "3KMXINssukXaAshl5THQbyP8L",
          apiSecretKey: "Rh7DBgXIzSeUFaOvO6LsQW9jVh2T8pprwZ9BHsPr8Etfq0p5fK",
          redirectURI: "twitterauth://");

      final authResult = await twitterLogin.loginV2();
      if (authResult.status == TwitterLoginStatus.loggedIn) {
        try {
          final credential = TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!);
          await _auth.signInWithCredential(credential);
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          Get.showSnackbar(GetSnackBar(
            title: e.toString(),
          ));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        Get.showSnackbar(const GetSnackBar(
          title: "Something went wrong",
        ));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.showSnackbar(GetSnackBar(
        title: e.toString(),
      ));
    }
  }
}
