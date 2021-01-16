import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/custom_navi_bar.dart';
import 'package:wallpaper_app/screens/home_screen/Home_screen.dart';
import 'package:wallpaper_app/screens/search_screen/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  Widget _switch(currentIndex) {
    if (currentIndex == 0) {
      print("Home");
      return HomeScreen();
    } else if (currentIndex == 1) {
      print("Search");
      return SearchScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.home_color,
      body: _switch(currentIndex),
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar(
        callback: (val) {
          setState(() {
            print(val);
            currentIndex = val;
          });
        },
      ),
    );
  }
}
