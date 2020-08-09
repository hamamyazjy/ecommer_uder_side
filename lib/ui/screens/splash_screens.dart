import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreens extends StatelessWidget {
  final Widget screen;
  SplashScreens({this.screen});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: screen,
        image: Image(image: AssetImage('assets/images/logo.png')),
          backgroundColor: Color(0xFF075C93),
        photoSize: 100.0,
      ),
    );
  }
}
