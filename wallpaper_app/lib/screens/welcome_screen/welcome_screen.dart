import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.welcome_color,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: screenHeight * 0.6,
          width: screenWidth * 0.6,
        ),
      ),
    );
  }
}
