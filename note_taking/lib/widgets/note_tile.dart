import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking/controllers/notes_controller.dart';

import '../utils.dart';

class NoteTile extends StatelessWidget {
  final int index;

  NoteTile({@required this.index});

  final NotesController notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Obx(() => Checkbox(
                activeColor: Colors.white,
                checkColor: CustomColors().secondaryColor,
                value: notesController.notes[index].done,
                onChanged: (bool val) {
                  var changed = notesController.notes[index];
                  changed.done = val;
                  notesController.notes[index] = changed;
                },
              )),
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.centerLeft,
              height: screenHeight * 0.1,
              width: screenWidth * 0.83,
              decoration: BoxDecoration(
                color: CustomColors().secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(-3, 3),
                  ),
                ],
              ),
              child: Text(
                notesController.notes[index].text,
                style: TextStyle(
                  decoration: notesController.notes[index].done
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.white,
                  decorationThickness: 3,
                  fontSize: 18,
                  color: Theme.of(context).primaryTextTheme.bodyText1.color,
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.1,
              width: 13,
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
