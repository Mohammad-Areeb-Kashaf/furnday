import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/auth/signin_screen.dart';
import 'package:furnday/screens/main_screens/main_screen.dart';
import 'package:furnday/services/network_services.dart';
import 'package:furnday/widgets/auth/auth_form.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                        'Sign up',
                        style: productNameTextStyle.copyWith(
                          color: Colors.black87,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Create a new account',
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
                      const SizedBox(height: 30),
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
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await _auth.currentUser!.updateDisplayName(name);
        formKey.currentState!.validate();
        formKey.currentState!.reset();
        await _auth.currentUser!.reload();
        Navigator.pop(context);
        Navigator.pop(context);
      });
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
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      NetworkStatusService().checkInternet();
      print(e);
    }
  }
}
