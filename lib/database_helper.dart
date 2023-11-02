// ignore: unused_import
import 'Note.dart';
// ignore: unused_import
import 'package:sqflite/sqflite.dart';
// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper =
      DatabaseHelper._databaseHelper; //singleton
  static Database _database = DatabaseHelper._database; //singleton

  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'Priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    // ignore: unnecessary_null_comparison
    if ((_databaseHelper == null)) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    // ignore: unused_local_variable
    Database db = await this.database;

    // optional
    // var result =
    //     await db.rawQuery('SELECT * from $noteTable order by $colPriority ASC');

    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colID=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colID=$id');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  // Future<List<Note>> getNoteList() async {
  //   var noteMapList = await getNoteMapList();

  //   int count = noteMapList.length;

  //   List<Note> noteList = List<Note>();
  //   for (var i = 0; i < count; i++) {
  //     noteList.add(
  //       Note.fromMapObject(noteMapList[i]),
  //     );
  //   }
  //   return noteList;
  // }
}
