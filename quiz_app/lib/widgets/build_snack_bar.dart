import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSnackBar(BuildContext context) {
  return Flushbar(
    message: "Number of Questions must be less then & equals to 50",
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue,
    ),
    duration: Duration(seconds: 2),
    leftBarIndicatorColor: Colors.blue,
  )..show(context);
}
