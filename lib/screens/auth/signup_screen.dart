import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/auth/signin_screen.dart';
import 'package:furnday/screens/main_screen.dart';
import 'package:furnday/widgets/auth/auth_form.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';

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
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((value) {
                                  formKey.currentState!.validate();
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    formKey.currentState!.reset();
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                      ),
                                    );
                                  });
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e);
                                Navigator.pop(context);
                                setState(() {
                                  AuthForm.authError = e.toString();
                                  formKey.currentState!.validate();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent)),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
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
          ],
        ),
      ),
    );
  }
}
