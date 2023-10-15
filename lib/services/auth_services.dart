import 'package:furnday/constants.dart';

class AuthServices extends StatelessWidget {
  final Widget isAuthenticatedChild, isNotAuthenticatedChild;
  AuthServices(
      {super.key,
      required this.isAuthenticatedChild,
      required this.isNotAuthenticatedChild});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitFoldingCube(
              color: kYellowColor,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong, Try again later'),
          );
        } else if (snapshot.hasData) {
          return isAuthenticatedChild;
        } else {
          return isNotAuthenticatedChild;
        }
      },
    );
  }
}
