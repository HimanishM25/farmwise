import 'package:farmwise/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xff00C880),
        cardColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.transparent,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
        drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xff00C880),
        cardColor: Colors.grey.shade800,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Ceres',
      home:RegisterScreen(),
    );
  }
}