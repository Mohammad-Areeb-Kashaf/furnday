import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/auth_screens/signup_screen.dart';
import 'package:furnday/services/network_services.dart';
import 'package:furnday/widgets/auth/auth_form.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    yellowColor,
                    orangeColor,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: scrollPhysics,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in',
                        style: productNameTextStyle.copyWith(
                          color: Colors.black87,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Login to your account',
                        style: productNameTextStyle.copyWith(
                          color: Colors.black38,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 30),
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
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: "Sign up Now!",
                                style: productNameTextStyle.copyWith(
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
          ],
        ),
      ),
    );
  }

  signIn({
    required String name,
    required String email,
    required String password,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: SpinKitFoldingCube(
          color: yellowColor,
        ),
      ),
    );
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          formKey.currentState!.validate();
          formKey.currentState!.reset();
          Navigator.pop(context);
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Navigator.pop(context);
      setState(() {
        AuthForm.authError = e.toString();
        formKey.currentState!.validate();
      });
    }
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
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: SpinKitFoldingCube(
            color: yellowColor,
          ),
        ),
      );
      await auth.signInWithCredential(credential);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      NetworkStatusService().checkInternet();
      print(e);
    }
  }
}
