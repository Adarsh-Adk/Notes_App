// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:notes/Controller/Controller.dart';
// import 'package:notes/constants/colors.dart';
// import 'package:notes/db/db.dart';
// import 'package:notes/models/model.dart';

// class Note extends StatefulWidget {
//   final Model note;
//   @override
//   _NoteState createState() => _NoteState();
//   Note({this.note});
// }

// class _NoteState extends State<Note> {
//   final Model note;

//   bool loading = false, editmode = false;

//   _NoteState({this.note});

//   final _controller = Get.put(Controller());

//   TextEditingController _titleController, _notesController;

//   @override
//   void initState() {
//     _titleController = TextEditingController(
//       text: "",
//     );
//     _notesController = TextEditingController(text: "");
//     if (widget.note.id != null) {
//       editmode = true;
//       _titleController.text = widget.note.title;
//       _notesController.text = widget.note.content;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colours().backgroundColor,
//         appBar: AppBar(
//           title: Text(editmode ? 'Edit' : 'Add'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.save),
//               onPressed: () {
//                 setState(() {
//                   loading = true;
//                   save();
//                 });
//               },
//             )
//           ],
//         ),
//         body: Container(
//           padding: EdgeInsets.all(4),
//           margin: EdgeInsets.all(2),
//           child: ListView(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 autofocus: true,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 style: TextStyle(fontSize: 30, color: Colours().textColor),
//                 decoration: InputDecoration(
//                     fillColor: Colours().cardColor,
//                     filled: false,
//                     border: InputBorder.none,
//                     hintText: "Title",
//                     hintStyle: TextStyle(color: Colours().hintColor)),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: _notesController,
//                 textInputAction: TextInputAction.done,
//                 maxLines: 20,
//                 style: TextStyle(fontSize: 20, color: Colours().textColor),
//                 decoration: InputDecoration(
//                     fillColor: Colours().cardColor,
//                     filled: false,
//                     border: InputBorder.none,
//                     hintText: "Add your notes here",
//                     hintStyle: TextStyle(color: Colours().hintColor)),
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<void> save() async {
//     if (_titleController.text != '') {
//       widget.note.title = _titleController.text;
//       widget.note.content = _notesController.text;
//       if (editmode)
//         await DB().update(widget.note);
//       else
//         await DB().add(widget.note);
//     }
//     print(widget.note.id);
//     setState(() => loading = false);
//     refresh();
//     Navigator.pop(context);
//   }

//   Future<void> refresh() async {
//     await DB().getNotes();
//     await _controller.fetchNotes();
//     setState(() => loading = false);
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Controller/Controller.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/db/db.dart';
import 'package:notes/models/model.dart';

class Note extends StatefulWidget {
  final Model note;
  @override
  _NoteState createState() => _NoteState();
  Note({this.note});
}

class _NoteState extends State<Note> {
  final Model note;

  bool loading = false, editmode = false;

  _NoteState({this.note});

  final _controller = Get.put(Controller());

  TextEditingController _titleController, _notesController;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: "",
    );
    _notesController = TextEditingController(text: "");
    if (widget.note.id != null) {
      editmode = true;
      _titleController.text = widget.note.title;
      _notesController.text = widget.note.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours().backgroundColor,
        appBar: AppBar(
          title: Text(editmode ? 'Edit' : 'Add'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                setState(() {
                  loading = true;
                  save();
                });
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(2),
          child: ListView(
            children: [
              TextField(
                controller: _titleController,
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 30, color: Colours().textColor),
                decoration: InputDecoration(
                    fillColor: Colours().cardColor,
                    filled: false,
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colours().hintColor)),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _notesController,
                textInputAction: TextInputAction.done,
                maxLines: 20,
                style: TextStyle(fontSize: 20, color: Colours().textColor),
                decoration: InputDecoration(
                    fillColor: Colours().cardColor,
                    filled: false,
                    border: InputBorder.none,
                    hintText: "Add your notes here",
                    hintStyle: TextStyle(color: Colours().hintColor)),
              ),
            ],
          ),
        ));
  }

  Future<void> save() async {
    if (_titleController.text != '') {
      widget.note.title = _titleController.text;
      widget.note.content = _notesController.text;
      print(editmode);
      if (editmode != false) {
        await DB().update(widget.note);
        // print("update:${widget.note.id}");
      } else {
        await DB().add(widget.note);
        // print("add:${widget.note.id}");
      }
    }
    setState(() => loading = false);
    refresh();
    Navigator.pop(context);
  }

  Future<void> refresh() async {
    await DB().getNotes();
    await _controller.fetchNotes();
    setState(() => loading = false);
  }
}
