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
    return LoadingOverlay(
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
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'Create a new account',
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
                              isSignIn: false,
                              onPressed: signUp,
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
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Sign in Now!",
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
        context.mounted
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen()))
            : null;
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
      context.mounted
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()))
          : null;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
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
}
