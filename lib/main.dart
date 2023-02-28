import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Furnday",
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          selectedTileColor: highlightColor,
          selectedColor: Colors.black,
        ),
        highlightColor: highlightColor,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: yellowColor,
            onPrimary: yellowColor,
            secondary: whiteBackground,
            onSecondary: whiteBackground,
            error: Colors.red,
            onError: Colors.red,
            background: whiteBackground,
            onBackground: whiteBackground,
            surface: whiteBackground,
            onSurface: whiteBackground),
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
        scaffoldBackgroundColor: whiteBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: yellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: radius,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: const Home(),
    );
  }
}
