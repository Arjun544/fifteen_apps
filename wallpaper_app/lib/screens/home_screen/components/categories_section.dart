import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/screens/Category_screen/category_screen.dart';

List<String> categoriesList = [
  "Nature",
  "Street Art",
  "Wild Life",
  "Motivation",
  "City",
  "Bikes",
  "Cars",
];

class CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryScreen(category: categoriesList[index]);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 0, top: 10),
              child: Container(
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: Constants.menu_color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  categoriesList[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
