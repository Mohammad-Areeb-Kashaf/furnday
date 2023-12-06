import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'constants.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(
      const Duration(seconds: 2), () => FlutterNativeSplash.remove());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "141124165550569",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      child: GetMaterialApp(
        title: "FurnDay",
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kYellowColor),
            ),
          ),
          textTheme: const TextTheme(
              displayLarge: TextStyle(color: Colors.black),
              displayMedium: TextStyle(color: Colors.black),
              displaySmall: TextStyle(color: Colors.black),
              headlineLarge: TextStyle(color: Colors.black),
              headlineMedium: TextStyle(color: Colors.black),
              headlineSmall: TextStyle(color: Colors.black),
              titleLarge: TextStyle(color: Colors.black),
              titleMedium: TextStyle(color: Colors.black),
              titleSmall: TextStyle(color: Colors.black),
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              bodySmall: TextStyle(color: Colors.black),
              labelMedium: TextStyle(
                fontWeight: FontWeight.w600,
                color: kGreyTextColor,
              ),
              labelLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelSmall: TextStyle(color: Colors.black)),
          listTileTheme: ListTileThemeData(
              selectedTileColor: kHighlightColor,
              selectedColor: Colors.black,
              style: ListTileStyle.drawer,
              titleTextStyle: Theme.of(context).textTheme.labelSmall),
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
        home: const Scaffold(
          body: MainScreen(),
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
