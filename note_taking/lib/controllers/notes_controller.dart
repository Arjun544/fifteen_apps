import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_taking/model/Note.dart';

class NotesController extends GetxController {
  var notes = List<Note>().obs;

  @override
  void onInit() {
    List storedNotes = GetStorage().read<List>('notes');

    if (!storedNotes.isNull) {
      notes = storedNotes.map((e) => Note.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      GetStorage().write('notes', notes.toList());
    });
    super.onInit();
  }
}
