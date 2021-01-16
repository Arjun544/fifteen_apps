import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNumberOfQues(
    {double width,
    double height,
    TextEditingController controller,
    Function onChanged}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '0',
        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
      ),
    ),
  );
}
