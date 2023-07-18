import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/controllers/cart_controller.dart';
import 'package:furnday/firebase_options.dart';
import 'package:furnday/screens/auth_screens/signin_screen.dart';
import 'package:furnday/screens/main_screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furnday/services/network_services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
        title: "FurnDay",
        theme: ThemeData(
          textTheme: const TextTheme(
            labelMedium: TextStyle(
              fontWeight: FontWeight.w600,
              color: kGreyTextColor,
            ),
            labelLarge: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          listTileTheme: const ListTileThemeData(
            selectedTileColor: kHighlightColor,
            selectedColor: Colors.black,
          ),
          highlightColor: kHighlightColor,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: kYellowColor,
              onPrimary: kYellowColor,
              secondary: kWhiteBackground,
              onSecondary: kWhiteBackground,
              error: Colors.red,
              onError: Colors.red,
              background: kWhiteBackground,
              onBackground: kWhiteBackground,
              surface: kWhiteBackground,
              onSurface: kWhiteBackground),
          buttonTheme: ButtonThemeData(
            colorScheme: Theme.of(context).colorScheme,
            highlightColor: Theme.of(context).highlightColor,
          ),
          primarySwatch: const MaterialColor(
            0xfff6c33c,
            <int, Color>{
              50: Color(0xffFEF8E8),
              100: Color(0xffFCEDC5),
              200: Color(0xffFBE19E),
              300: Color(0xffF9D577),
              400: Color(0xffF7CC59),
              500: Color(0xffF6C33C),
              600: Color(0xffF5BD36),
              700: Color(0xffF3B52E),
              800: Color(0xffF2AE27),
              900: Color(0xffEFA11A),
            },
          ),
          scaffoldBackgroundColor: kWhiteBackground,
          appBarTheme: const AppBarTheme(
            backgroundColor: kYellowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: kRadius,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: Scaffold(
          body: StreamBuilder<User?>(
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
                  child: AutoSizeText('Something went wrong, Try again later'),
                );
              } else if (snapshot.hasData) {
                return const MainScreen();
              } else {
                return const SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
