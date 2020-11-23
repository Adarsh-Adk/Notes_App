import 'package:flutter/material.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/db/db.dart';
import 'package:notes/models/model.dart';
import 'package:notes/pages/note.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  List<Model> notes=[];
  bool loading = true;
  Model note;


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
      body: GridView.builder(
          itemCount: notes.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            Model note = notes[index];
            return Container(
                padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
                alignment: AlignmentDirectional.center,
                child: GestureDetector(
                    onLongPress: () {},
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Note(note: note,)));
                    },
                    child: Card(
                      color: Colours().cardColor,
                      child: Container(
                          height: MediaQuery.of(context).size.width * 0.49,
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: Center(
                            child: ListTile(
                              title: Text(note.title,maxLines: 3,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              subtitle: Text(note.content,maxLines: 3,style: TextStyle(fontSize: 13,),textAlign: TextAlign.center,),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete), onPressed: ()async{setState(() {
                                    loading = true;
                                    delete(notes[index]);
                                    refresh();
                                  });}),
                              selected: true,
                            ),
                          )),
                    )));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => loading = true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Note(note: Model()))).then((v) {
            refresh();
          });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() => loading = false);
  }
  Future<void> delete(v) async {
    await DB().delete(v);
    setState(() {
      loading = true;
    });
  }
}


