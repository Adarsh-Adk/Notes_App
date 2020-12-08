import 'package:get/get.dart';
import 'package:notes/db/db.dart';
import 'package:notes/models/model.dart';

class Controller extends GetxController {
  var notes = List<Model>().obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  fetchNotes() async {
    var getNotes = await DB().getNotes();
    notes.assignAll(getNotes);
  }

  // update()async{

  // }
}
