import 'package:flutter/material.dart';


class HomeScreenText extends StatelessWidget {

  final String name;

  HomeScreenText(this.name);

  @override
  Widget build(BuildContext context) {
    return  Text(name.toUpperCase(),
      style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }
}