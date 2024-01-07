import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/landing_background.png"),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              height: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
