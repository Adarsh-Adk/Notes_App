// import 'package:flutter/material.dart';
// import 'package:notes/constants/colors.dart';
// import 'package:notes/db/db.dart';
// import 'package:notes/models/model.dart';
// import 'package:notes/pages/note.dart';

// class HomeApp extends StatefulWidget {
//   @override
//   _HomeAppState createState() => _HomeAppState();
// }

// class _HomeAppState extends State<HomeApp> {
//   List<Model> notes = [];
//   bool loading = true;
//   Model note;

//   @override
//   void initState() {
//     super.initState();
//     refresh();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colours().backgroundColor,
//       appBar: AppBar(
//         title: Text("Notes"),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 setState(() {
//                   refresh();
//                 });
//               })
//         ],
//       ),
//       body: GridView.builder(
//           itemCount: notes.length,
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           itemBuilder: (context, index) {
//             Model note = notes[index];
//             return Container(
//                 padding: EdgeInsets.all(3),
//                 alignment: AlignmentDirectional.center,
//                 child: GestureDetector(
//                     onLongPress: () {},
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Note(
//                                     note: note,
//                                   )));
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       color: Colours().cardColor,
//                       child: Container(
//                           padding: EdgeInsets.all(10),
//                           height: MediaQuery.of(context).size.width * 0.49,
//                           width: MediaQuery.of(context).size.width * 0.49,
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   note.title,
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colours().textColor),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                     height: (MediaQuery.of(context).size.width *
//                                             0.15) -
//                                         9,
//                                     child: Text(
//                                       note.content,
//                                       maxLines: 3,
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colours().textColor),
//                                       textAlign: TextAlign.start,
//                                     )),
//                                 SizedBox(
//                                   height: 25,
//                                 ),
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.delete_forever,
//                                       color: Colours().textColor,
//                                     ),
//                                     onPressed: () async {
//                                       setState(() {
//                                         loading = true;
//                                         delete(notes[index]);
//                                         refresh();
//                                       });
//                                     }),
//                               ],
//                             ),
//                           )),
//                     )));
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() => loading = true);
//           Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Note(note: Model())))
//               .then((v) {
//             refresh();
//           });
//         },
//         backgroundColor: Colours().cardColor,
//         child: Icon(
//           Icons.add,
//           size: 50,
//           color: Colours().mainColor,
//         ),
//       ),
//     );
//   }

//   Future<void> refresh() async {
//     notes = await DB().getNotes();
//     setState(() => loading = false);
//   }

//   Future<void> delete(v) async {
//     await DB().delete(v);
//     setState(() {
//       loading = true;
//     });
//   }
// }

// ------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Controller/Controller.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/db/db.dart';
import 'package:notes/models/model.dart';
import 'package:notes/pages/note.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  List<Model> notes = [];
  bool loading = true;
  Model note;
  final notesController = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours().backgroundColor,
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: GetX<Controller>(builder: (controller) {
        return GridView.builder(
            itemCount: controller.notes.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              print("app repainted");
              return Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 3, top: 5, bottom: 0),
                  alignment: AlignmentDirectional.center,
                  child: GestureDetector(
                      onLongPress: () {},
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Note(
                                      note: controller.notes[index],
                                    )));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colours().cardColor,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 5),
                            height: MediaQuery.of(context).size.width * 0.49,
                            width: MediaQuery.of(context).size.width * 0.49,
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    // note.title,
                                    "${controller.notes[index].title}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colours().textColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height:
                                          (MediaQuery.of(context).size.width *
                                                  0.15) -
                                              9,
                                      child: Text(
                                        // note.content,
                                        "${controller.notes[index].content}",
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colours().textColor),
                                        textAlign: TextAlign.start,
                                      )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colours().textColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                          delete(controller.notes[index]);
                                          refresh();
                                        });
                                      }),
                                ],
                              ),
                            )),
                      )));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => loading = true);
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Note(note: Model())))
              .then((v) {
            refresh();
          });
        },
        backgroundColor: Colours().cardColor,
        child: Icon(
          Icons.add,
          size: 50,
          color: Colours().mainColor,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    notes = await DB().getNotes();
    await notesController.fetchNotes();
    setState(() => loading = false);
  }

  Future<void> delete(v) async {
    await DB().delete(v);
    await notesController.fetchNotes();

    setState(() {
      loading = true;
    });
  }
}
