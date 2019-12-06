
import 'dart:core';
import 'dart:io';

import 'package:first_flutter_app/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper{

  static DataBaseHelper _dataBaseHelper; //singleton Instance for DataBaseHelper

  DataBaseHelper._createInstance(); // Named constructor for create Instance of this Helper

  factory DataBaseHelper(){
    if(_dataBaseHelper == null){
      _dataBaseHelper = DataBaseHelper._createInstance(); // Initialized only once (bcz singleton) in app lifecycle
    }
    return _dataBaseHelper;
  }

  static Database _database ;
  String tableNote = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDB();
    }
    return _database;
  }

 Future<Database> initializeDB() async {
    //get directory path for both android & iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path  = directory.path + "notes.db";

    // Open/Create database at given path..
    var notesDatabase = await openDatabase(path,version:1,onCreate: _createDataBase);
    return notesDatabase;
  }

  void _createDataBase(Database db, int version) async{
    await db.execute('CREATE TABLE $tableNote($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  // Fetch all note object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    return db.query(tableNote, orderBy: '$colPriority ASC');
  }

  // Insert a Note to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    return db.insert(tableNote, note.toMap() );
  }

  //update a note object and save into database
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    return db.update(tableNote, note.toMap(), where: '$colId = ?',whereArgs: [note.id]);
  }

  // delete a note form database
  Future<int> deleteNote(Note note) async {
    Database db = await this.database;
    return db.delete(tableNote,where: '$colId = ?',whereArgs: [note.id]);
  }

  //count number of row in database
  Future<int> getNumberOfRow() async {
    Database  db = await this.database;
    List<Map<String,dynamic>> result = await db.rawQuery('SELECT COUNT(*) FROM $tableNote');
    return Sqflite.firstIntValue(result);
  }

  // get converted Map Not list to List
  Future<List<Note>> getNoteList() async {
    var notmaplist = await getNoteMapList();
    List<Note> list = List<Note>();
    for(int i = 0 ; i < notmaplist.length;i++){
      list.add(Note.mapToObject(notmaplist[i]));
    }
    return list;
   }

}