import 'package:furnday/constants.dart';

class MainEmailNotVerifiedChild extends StatefulWidget {
  const MainEmailNotVerifiedChild(
      {super.key,
      required this.canResendEmail,
      required this.sendVerificationEmail});

  final bool canResendEmail;
  final Function sendVerificationEmail;

  @override
  State<MainEmailNotVerifiedChild> createState() =>
      _MainEmailNotVerifiedChildState();
}

class _MainEmailNotVerifiedChildState extends State<MainEmailNotVerifiedChild> {
  final _auth = FirebaseAuth.instance;

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
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: DecoratedCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'Verify Email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.black87,
                                      ),
                                  minFontSize: 24,
                                  maxFontSize: 32,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                AutoSizeText.rich(
                                  TextSpan(
                                    text:
                                        'A verification email has been sent to your email address\n',
                                    children: [
                                      TextSpan(
                                        text: _auth.currentUser!.email,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  minFontSize: 14,
                                  maxFontSize: 22,
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: widget.canResendEmail
                                      ? () => widget.sendVerificationEmail
                                      : null,
                                  icon: const Icon(
                                    Icons.email,
                                    size: 32,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    'Resent Email',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: () {
                                    _auth.signOut();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Cancel',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
