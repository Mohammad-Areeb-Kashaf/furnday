import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/auth_screens/reset_password_screen.dart';
import 'package:furnday/widgets/auth/auth_text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.isSignIn,
    required this.onPressed,
    required this.signInWithGoogle,
    required this.formkey,
  });
  final bool isSignIn;
  final Function onPressed;
  final Function signInWithGoogle;
  static String? authError = 'null';
  final GlobalKey<FormState> formkey;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: widget.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.isSignIn
                ? const SizedBox.shrink()
                : const SizedBox(height: 20),
            widget.isSignIn
                ? const SizedBox.shrink()
                : AuthTextField(
                    controller: nameController,
                    labelText: 'Name',
                    validate: validateName,
                    keyboardType: TextInputType.text,
                  ),
            const SizedBox(height: 20),
            AuthTextField(
              controller: emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validate: validateEmail,
            ),
            const SizedBox(height: 20),
            AuthTextField(
                controller: passwordController,
                labelText: widget.isSignIn ? 'Password' : 'Create Password',
                validate: validatePassword,
                keyboardType: TextInputType.text,
                obscureText: true),
            widget.isSignIn
                ? const SizedBox.shrink()
                : const SizedBox(height: 20),
            widget.isSignIn
                ? const SizedBox.shrink()
                : AuthTextField(
                    controller: confirmPasswordController,
                    labelText: 'Confirm password',
                    validate: validateConfirmPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
            widget.isSignIn
                ? const SizedBox(height: 10)
                : const SizedBox.shrink(),
            widget.isSignIn
                ? GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    ),
                    child: const AutoSizeText(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                      maxFontSize: 18,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 14),
            MaterialButton(
              height: 48,
              shape: RoundedRectangleBorder(borderRadius: borderRadiusCard),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  AuthForm.authError = 'null';
                });
                if (widget.formkey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  widget.onPressed(
                    name: name,
                    email: email,
                    password: password,
                  );
                }
              },
              child: AutoSizeText(
                widget.isSignIn ? 'Sign In' : 'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
                minFontSize: 16,
                maxFontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 2.0,
                    color: Colors.grey.shade400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: const AutoSizeText("OR",
                      style: TextStyle(color: Colors.black38)),
                ),
                Expanded(
                  child: Container(
                    height: 2.0,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => widget.signInWithGoogle(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset("assets/images/google.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: tapSignInWithOther,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: tapSignInWithOther,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset("assets/images/twitter.png"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Password should not be empty";
    } else if (value.length < 6) {
      return 'Password length should be at least 6';
    } else if (AuthForm.authError != 'null') {
      if (AuthForm.authError ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        setState(() {
          passwordController.text = '';
        });
        return 'Password is incorrect';
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

  validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return "Confirm password should not be empty";
    } else if (value.length < 6) {
      return 'Password length should be at least 6';
    } else if (value.toString().trim() !=
        passwordController.text.toString().trim()) {
      return "Password didn't match";
    }
  }

  tapSignInWithOther() {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: AutoSizeText(
            'Not Implemented Yet',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
  }

  validateName(String value) {
    if (value.isEmpty) {
      return "Name should not be empty";
    } else if (value.length < 6) {
      return 'Name length should be at least 6';
    } else {
      return null;
    }
  }
}
