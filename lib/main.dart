import 'package:flutter/material.dart';
import 'package:startup_app/screens/phone_input/phone_number_input_screen.dart';
import 'package:startup_app/screens/code_input/code_input_screen.dart';
import 'package:startup_app/screens/map_screen/map_screen.dart';
import 'package:startup_app/screens/splash_screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarPoint',
      theme: ThemeData(
        fontFamily: 'HelveticaNeue',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'HelveticaNeue'),
          displayMedium: TextStyle(fontFamily: 'HelveticaNeue'),
          displaySmall: TextStyle(fontFamily: 'HelveticaNeue'),
          headlineLarge: TextStyle(fontFamily: 'HelveticaNeue'),
          headlineMedium: TextStyle(fontFamily: 'HelveticaNeue'),
          headlineSmall: TextStyle(fontFamily: 'HelveticaNeue'),
          titleLarge: TextStyle(fontFamily: 'HelveticaNeue'),
          titleMedium: TextStyle(fontFamily: 'HelveticaNeue'),
          titleSmall: TextStyle(fontFamily: 'HelveticaNeue'),
          bodyLarge: TextStyle(fontFamily: 'HelveticaNeue'),
          bodyMedium: TextStyle(fontFamily: 'HelveticaNeue'),
          bodySmall: TextStyle(fontFamily: 'HelveticaNeue'),
          labelLarge: TextStyle(fontFamily: 'HelveticaNeue'),
          labelMedium: TextStyle(fontFamily: 'HelveticaNeue'),
          labelSmall: TextStyle(fontFamily: 'HelveticaNeue'),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(const Color(0xFF1D1932)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Set default background color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              createMaterialColor(const Color(0xFFF1F2F4)),
            ),
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/phone': (context) => const PhoneNumberInputScreen(),
        '/code': (context) => CodeInputScreen(),
        '/map': (context) => const MapScreen(),
        '/new_car': (context) => const MapScreen(),
      },
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
