import 'package:notes/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  static Database _database;
  static const NAME="Notes.db";
  static const VERSION=1;
  static const TABLE_NAME="Notes";

  Future<Database> get db async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async {
    var dir = await getDatabasesPath();
    String path = join(dir, NAME);
    var database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database _db, int version) async {
          await _db.execute(
              'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, date INTEGER, title TEXT, content TEXT)'
          );
        }
    );
    return database;
  }

  Future<void>add(Model note)async{
    var database=await db;
    note.setDate();
    await database.insert(TABLE_NAME, note.toMap());

  }
  Future<void>update(Model note)async{
    var database=await db;
    note.setDate();
    await database.update(TABLE_NAME, note.toMap(),where: "id=?",whereArgs: [note.id]);

  }
  Future<void>delete(Model note)async{
    var database=await db;
    await database.delete(TABLE_NAME,where: "id=?",whereArgs: [note.id]);
  }
  Future<List<Model>>getNotes()async{
    var database=await db;
    List<Map<String,dynamic>>maps=await database.rawQuery("SELECT * FROM $TABLE_NAME ORDER BY date DESC");
    List<Model>notes=List<Model>();
    for (Map<String,dynamic> map in maps){
      notes.add(Model.fromMap(map));
    }
    return notes;

  }

}