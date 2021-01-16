import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taking/controllers/notes_controller.dart';
import 'package:note_taking/model/Note.dart';

import 'package:note_taking/utils.dart';
import 'package:note_taking/widgets/add_field.dart';

class AddNoteScreen extends StatelessWidget {
  final int index;

  AddNoteScreen({this.index});

  final TextEditingController textEditingController = TextEditingController();
  final NotesController notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    String text = '';
    if (!this.index.isNull) {
      text = notesController.notes[index].text;
    }

    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors().backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          this.index.isNull ? 'Add Note' : 'Edit Note',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          addField(
            this.index.isNull
                ? 'Enter title'
                : notesController.notes[index].text,
            screenWidth,
            screenHeight * 0.09,
            textEditingController,
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: CustomColors().secondaryColor,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () {
            if (this.index.isNull) {
              notesController.notes.add(Note(text: textEditingController.text));
            } else {
              var editing = notesController.notes[index];
              editing.text = textEditingController.text;
              notesController.notes[index] = editing;
            }

            textEditingController.text.length == 0
                ? Get.snackbar(
                    'Field is empty',
                    'Please write something to save.',
                    backgroundColor: CustomColors().secondaryColor,
                  )
                : Get.back();
          },
          child: Text(
            'Save',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
