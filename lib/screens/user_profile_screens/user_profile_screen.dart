import 'package:furnday/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          shape: const ContinuousRectangleBorder(),
          title: const AutoSizeText(
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
                            child: Hero(
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
                              '${_auth.currentUser!.displayName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxFontSize: 22,
                            ),
                          ),
                          Center(
                            child: AutoSizeText(
                              '${_auth.currentUser!.email}',
                              style: const TextStyle(
                                color: Colors.black38,
                              ),
                              maxFontSize: 16,
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
                                  title: const AutoSizeText('My Orders'),
                                  leading: const Icon(Icons.shopping_bag),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                ListTile(
                                  onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const MyAddressesScreen(),
                                    ),
                                  ),
                                  title: const AutoSizeText('My Addresses'),
                                  leading: const Icon(Icons.location_pin),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                const ListTile(
                                  title: AutoSizeText('Settings'),
                                  leading: Icon(Icons.settings),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (_auth.currentUser!.providerData
                                          .contains("google")) {
                                        await GoogleSignIn().disconnect();
                                        await _auth.signOut();
                                      } else {
                                        await _auth.signOut();
                                      }
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      var errorData = {
                                        "errors": [e.toString()]
                                      };
                                      await FirebaseFirestore.instance
                                          .collection("app")
                                          .doc('errors')
                                          .update(errorData);
                                      NetworkStatusService().checkInternet();
                                    }
                                  },
                                  child: const AutoSizeText(
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
    );
  }
}
