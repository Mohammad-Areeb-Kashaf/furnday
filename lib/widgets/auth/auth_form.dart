import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthForm extends StatefulWidget {
  AuthForm({
    super.key,
    required this.isSignIn,
    required this.onPressed,
    required this.formkey,
  });
  final bool isSignIn;
  final Function onPressed;
  static String? authError = 'null';
  final GlobalKey<FormState> formkey;

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required Function validate,
    required TextInputType keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
      cursorHeight: 24,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusCard,
          borderSide: const BorderSide(color: yellowColor),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadiusCard,
          borderSide: const BorderSide(color: yellowColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadiusCard,
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 24),
      ),
      validator: (value) => validate(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: widget.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildTextFormField(
              controller: AuthForm.emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validate: validateEmail,
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
                controller: AuthForm.passwordController,
                labelText: widget.isSignIn ? 'Password' : 'Create Password',
                validate: validatePassword,
                keyboardType: TextInputType.text,
                obscureText: true),
            widget.isSignIn
                ? const SizedBox.shrink()
                : const SizedBox(height: 20),
            widget.isSignIn
                ? const SizedBox.shrink()
                : _buildTextFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm password',
                    validate: validateConfirmPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 14),
            MaterialButton(
              height: 48,
              shape: RoundedRectangleBorder(borderRadius: borderRadiusCard),
              color: yellowColor,
              onPressed: () {
                setState(() {
                  AuthForm.authError = 'null';
                });
                if (widget.formkey.currentState!.validate()) {
                  final email = AuthForm.emailController.text.trim();
                  final password = AuthForm.passwordController.text.trim();
                  widget.onPressed(
                    email: email,
                    password: password,
                  );
                }
              },
              child: Text(
                widget.isSignIn ? 'Sign In' : 'Sign Up',
                style: productNameTextStyle.copyWith(color: Colors.white),
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
                  child:
                      const Text("OR", style: TextStyle(color: Colors.black38)),
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
                InkWell(
                  onTap: signInWithGoogle,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset("assets/images/google.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: tapSignInWithOther,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
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
          AuthForm.passwordController.text = '';
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
    } else if (value.toString() !=
        AuthForm.passwordController.text.toString()) {
      return "Password didn't match";
    }
  }

  tapSignInWithOther() {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Not Implemented Yet',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
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
      await auth.signInWithCredential(credential);
      final userUid = auth.currentUser!.uid;

      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    } catch (e) {
      // NetworkStatusService().checkInternet();
      print(e);
    }
  }
}
