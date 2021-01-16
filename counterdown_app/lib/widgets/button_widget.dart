import 'package:flutter/material.dart';

Widget button(String text, {Function onPressed, Color color}) {
  return Container(
    width: 200,
    height: 50,
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
        color: color ?? Colors.redAccent,
        borderRadius: BorderRadius.circular(15)),
    child: MaterialButton(
        child: Text(
          '$text',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: onPressed),
  );
}
