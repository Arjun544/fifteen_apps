import 'package:flutter/material.dart';
import 'constants.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) callback;

  CustomNavigationBar({this.callback});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(right: 90,left: 90, bottom: 25),
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Constants.menu_color,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Constants.menu_color.withOpacity(0.4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildNaviBarItem(Icons.home, 0, () {}),
          buildNaviBarItem(Icons.search, 1, () {}),
        ],
      ),
    );
  }

  Widget buildNaviBarItem(IconData icon, int index, Function onPressed) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          onPressed();
          widget.callback(index);
        });
      },
      child: Icon(
        icon,
        color: index == _selectedIndex
            ? Colors.white
            : Constants.text_Color.withOpacity(0.6),
        size: 38,
      ),
    );
  }
}
