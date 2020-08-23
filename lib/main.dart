import 'package:flutter/material.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/screens/register_screen.dart';
import 'package:padimall_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(206, 160, 30, 0.1),
    100: Color.fromRGBO(206, 160, 30, 0.2),
    200: Color.fromRGBO(206, 160, 30, 0.3),
    300: Color.fromRGBO(206, 160, 30, 0.4),
    400: Color.fromRGBO(206, 160, 30, 0.5),
    500: Color.fromRGBO(206, 160, 30, 0.6),
    600: Color.fromRGBO(206, 160, 30, 0.7),
    700: Color.fromRGBO(206, 160, 30, 0.8),
    800: Color.fromRGBO(206, 160, 30, 0.9),
    900: Color.fromRGBO(206, 160, 30, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF84B214, color),
        primaryColor: MaterialColor(0xFF84B214, color),
        accentColor: MaterialColor(0xFFF97C2D, color),
        toggleableActiveColor: MaterialColor(0xFF84B214, color),
        indicatorColor: MaterialColor(0xFF84B214, color),
        backgroundColor: Colors.grey[100],
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        FirstScreen.routeName: (ctx) => FirstScreen(),
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}