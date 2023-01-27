import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game/screens/login_screen.dart';
import 'package:game/components/splash_screen_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(const LoginScreen())));
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(alignment: Alignment.center,
        children: [
          const Image(image: NetworkImage('https://i.pinimg.com/564x/01/18/52/011852906ece0bf2c2be1442d78b73b6.jpg'),
              height: double.infinity,
              fit: BoxFit.cover),
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SplashScreenText('rock'),
              SplashScreenText('paper'),
              SplashScreenText('scissors'),
            ],
          ),
        ],
      ),
    );
  }
}
