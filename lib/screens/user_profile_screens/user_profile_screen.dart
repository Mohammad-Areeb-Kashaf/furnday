import 'package:furnday/constants.dart';
import 'package:furnday/services/auth_services.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: AuthServices(
        isNotAuthenticatedChild: Scaffold(
          appBar: myAppBar(context, isNotAuthenticated: true),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You are not Signed in, please sign in', style: Theme.of(context).textTheme.labelSmall,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      
                      child:  Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),),
                  ],
                ),
              ],
            ),
          ),
        ),
        isAuthenticatedChild: Scaffold(
          appBar: AppBar(
            shape: const ContinuousRectangleBorder(),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            foregroundColor: Colors.transparent,
            elevation: 0.0,
          ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const UserProfileScreen(),
                                  ),
                                );
                              },
                              child: const Hero(
                                tag: "profile_img",
                                transitionOnUserGestures: true,
                                child: UserProfileImage(
                                  isAppBar: false,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: AutoSizeText(
                                _auth.currentUser != null
                                    ? _auth.currentUser!.displayName.toString()
                                    : "null",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxFontSize: 22,
                              ),
                            ),
                            Center(
                              child: AutoSizeText(
                                _auth.currentUser != null
                                    ? _auth.currentUser!.email.toString()
                                    : "null",
                                style: const TextStyle(
                                  color: Colors.black38,
                                ),
                                minFontSize: 14,
                                maxFontSize: 16,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: DecoratedCard(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const MyOrdersScreen())),
                                    title: const Text('My Orders'),
                                    leading: const Icon(
                                      Icons.shopping_bag,
                                      color: Colors.black,
                                    ),
                                    trailing: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const MyAddressesScreen(),
                                      ),
                                    ),
                                    title: const Text('My Addresses'),
                                    leading: const Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                    trailing: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await GoogleSignIn().signOut();
                                        await FacebookAuth.instance.logOut();
                                        await _auth.signOut();

                                        (_auth.currentUser == null)
                                            ? (context.mounted)
                                                ? Navigator.of(context).pop()
                                                : null
                                            : null;
                                      } catch (e) {
                                        printError(info: e.toString());
                                        NetworkStatusService().checkInternet();
                                      }
                                    },
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
