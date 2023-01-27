import 'package:flutter/material.dart';

class SplashScreenText extends StatelessWidget {
  final String name;

  SplashScreenText(this.name);

  @override
  Widget build(BuildContext context) {
    return Text(name.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 50,
      ),
    );
  }
}
