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
                              onPressed: ({
                                required String name,
                                required String email,
                                required String password,
                              }) =>
                                  signUp(
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
    try {
      await auth.signInWithCredential(credential);
      if (context.mounted) Navigator.pop(context);
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
