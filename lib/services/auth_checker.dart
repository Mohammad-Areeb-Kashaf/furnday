import 'package:furnday/constants.dart';

class AuthChecker {
  AuthChecker(
      {required this.isAuthenticatedFunction,
      required this.isNotAuthenticatedFunction});
  final Function isAuthenticatedFunction, isNotAuthenticatedFunction;

  checkAuth() {
    final auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((snapshot) {
      if (snapshot != null) {
        isAuthenticatedFunction();
      } else {
        Get.deleteAll(force: true);
        isNotAuthenticatedFunction();
      }
    });
  }
}
