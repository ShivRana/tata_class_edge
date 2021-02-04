import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'package:tata_classedge/db/note_model.dart';
import 'package:tata_classedge/util/const.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, Const.DATABASE_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Notes ("
          "id INTEGER PRIMARY KEY,"
          "note_id TEXT,"
          "note_position INTEGER,"
          "notes TEXT"
          ")");
    });
  }

  newNote(Notes newNote) async {
    final db = await database;
    var res = await db.insert("Notes", newNote.toJson());
    return res;
  }

  getAllNotes() async {
    final db = await database;
    var res = await db.query("Notes");
    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromJson(c)).toList() : [];
    return list;
  }
}
