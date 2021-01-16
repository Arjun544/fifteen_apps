import 'package:flutter/material.dart';

Widget addField(String text,double width, double height,
    TextEditingController controller) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: EdgeInsets.only(left: 20),
    alignment: Alignment.center,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.blueGrey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: text,
        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
      ),
    ),
  );
}
