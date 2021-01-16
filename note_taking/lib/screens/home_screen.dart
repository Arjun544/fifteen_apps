import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_taking/controllers/notes_controller.dart';
import 'package:note_taking/screens/add_note_Screen.dart';
import 'package:note_taking/utils.dart';
import 'package:note_taking/widgets/dismiss_background.dart';
import 'package:note_taking/widgets/note_tile.dart';

class HomeScreen extends StatelessWidget {
  final NotesController notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors().backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Text(
            'Notes',
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.64,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notesController.notes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    background:
                        dismissBackground(), // Swipe to delete note from list
                    key: UniqueKey(),
                    onDismissed: (_) {
                      var removed = notesController.notes[index];
                      notesController.notes.removeAt(index);
                      Get.snackbar('Task removed',
                          'The task "${removed.text}" was successfully removed.',
                          backgroundColor: Colors.amber.withOpacity(0.7),
                          mainButton: FlatButton(
                            child: Text(
                              'Undo',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (removed.isNull) {
                                return;
                              }
                              notesController.notes.insert(index, removed);
                              removed = null;
                              if (Get.isSnackbarOpen) {
                                Get.back();
                              }
                            },
                          ));
                    },
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          AddNoteScreen(
                            index: index,
                          ),
                        );
                      },
                      child: NoteTile(
                        index: index,
                      ),
                    ));
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddNoteScreen();
            }),
          );
        },
        backgroundColor: CustomColors().secondaryColor,
        elevation: 0,
        child: Icon(Icons.add),
      ),
    );
  }
}
