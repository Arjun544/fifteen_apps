import 'package:flutter/material.dart';

Widget customBotton({
  String text,
  BuildContext context,
  Color color,
  Color textColor,
  Function onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 80,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}
