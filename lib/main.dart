import 'package:dsw_aplikacje_mobilne_projekt/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobiDSW',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF471AA0)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
