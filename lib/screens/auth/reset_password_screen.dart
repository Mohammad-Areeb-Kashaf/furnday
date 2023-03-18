import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/auth/auth_form.dart';
import 'package:furnday/widgets/auth/auth_text_field.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isEmailSent = false;

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
                  child: isEmailSent
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Check your mail',
                              style: productNameTextStyle.copyWith(
                                color: Colors.black87,
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              'We have sent a reset password link to your email.',
                              textAlign: TextAlign.center,
                              style: productNameTextStyle.copyWith(
                                color: Colors.black38,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reset Password',
                              style: productNameTextStyle.copyWith(
                                color: Colors.black87,
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              'Enter the email associated with your account and we\'ll send an email with a link to reset your password.',
                              textAlign: TextAlign.center,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 20),
                                        AuthTextField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          labelText: 'Email',
                                          validate: validateEmail,
                                        ),
                                        const SizedBox(height: 20),
                                        MaterialButton(
                                          height: 48,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: borderRadiusCard,
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final email =
                                                  emailController.text.trim();

                                              await _auth
                                                  .sendPasswordResetEmail(
                                                email: email,
                                              );

                                              setState(() {
                                                isEmailSent = true;
                                              });
                                            }
                                          },
                                          child: Text(
                                            'Reset Password',
                                            style: productNameTextStyle
                                                .copyWith(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
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
            )
          ],
        ),
      ),
    );
  }

  validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value) || value.isEmpty) {
      return 'Enter a valid email address';
    } else if (AuthForm.authError != 'null') {
      if (AuthForm.authError ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        return 'Looks like your email is invalid';
      } else if (AuthForm.authError ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        return 'Email already in use, Login instead?';
      } else if (AuthForm.authError ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        return 'This email address is not correctly formatted';
      } else if (AuthForm.authError ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        return 'User is not found';
      } else if (AuthForm.authError ==
          '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.') {
        return 'Too many request from this device. Please try again later';
      } else if (AuthForm.authError ==
          '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        return 'Internet unavailable. Please connect your mobile to a internet connection';
      }
    } else {
      return null;
    }
  }
}
