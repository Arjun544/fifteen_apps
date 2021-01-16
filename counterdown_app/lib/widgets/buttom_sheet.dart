import 'package:flutter/material.dart';

Future<void> bottomSheet(BuildContext context, Widget child, {double height}) {
  return showModalBottomSheet(
    isScrollControlled: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => Container(
      height: height ?? MediaQuery.of(context).size.height / 3,
      child: child,
    ),
  );
}
