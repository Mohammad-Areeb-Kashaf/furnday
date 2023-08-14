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
                        ),
                        AutoSizeText(
                          'Login to your account',
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
                              isSignIn: true,
                              onPressed: (
                                      {required String name,
                                      required String email,
                                      required String password}) =>
                                  signIn(
                                      name: name,
                                      email: email,
                                      password: password),
                              signInWithGoogle: signInWithGoogle,
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
                              CupertinoPageRoute(
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
    } on FirebaseAuthException catch (e) {
      print(e);

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
      final auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ["email"]).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      setState(() {
        isLoading = true;
      });

      await auth.signInWithCredential(credential);
    } catch (e) {
      NetworkStatusService().checkInternet();
      var errorData = {
        "errors": [e.toString()]
      };
      await FirebaseFirestore.instance
          .collection("app")
          .doc('errors')
          .update(errorData);
    }
    setState(() {
      isLoading = false;
    });
  }
}
