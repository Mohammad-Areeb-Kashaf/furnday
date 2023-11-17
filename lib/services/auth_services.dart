import 'package:furnday/constants.dart';

class AuthServices extends StatefulWidget {
  final Widget isAuthenticatedChild, isNotAuthenticatedChild;

  const AuthServices(
      {super.key,
      required this.isAuthenticatedChild,
      required this.isNotAuthenticatedChild});

  @override
  State<AuthServices> createState() => _AuthServicesState();
}

class _AuthServicesState extends State<AuthServices> {
  final _auth = FirebaseAuth.instance;
  late final User? user;
  bool isUserSignedIn = false;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    timer = Timer.periodic(
        const Duration(microseconds: 0), (timer) => checkUserSignedIn());
  }

  checkUserSignedIn() {
    setState(() {
      if (user != null) {
        isUserSignedIn = true;
      } else {
        isUserSignedIn = false;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isUserSignedIn) {
      return widget.isNotAuthenticatedChild;
    } else {
      return widget.isAuthenticatedChild;
    }
  }
}
