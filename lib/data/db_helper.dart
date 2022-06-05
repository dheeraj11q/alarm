import 'dart:io';
import 'package:alarm/data/alarm_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Databasehelper {
  static const _databasename = "persons.db";
  static const _databaseversion = 1;

  static const table = "my_table";

  static const columnId = "id";
  static const columnName = "name";
  static const columnDateTime = "datetime";
  static const columnIsOn = "isOn";

  static Database? _database;

// for making single incetance
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

// Checking database is or not
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

//creating database path

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _oncreate);
  }

  // creating database
  Future _oncreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table 
    ($columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnDateTime TEXT NOT NULL,
    $columnIsOn TEXT NOT NULL
    )
    
    ''');
  }

  //function to insert, query , update, delete

  //insert func

  Future<int> insert(AlarmModel alarmModel) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      columnName: alarmModel.name,
      columnDateTime: alarmModel.dateTime.toString(),
      columnIsOn: alarmModel.isOn.toString()
    };
    return await db.insert(table, row);
  }

  // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // function to queryspecific
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database db = await instance.database;
    var res = await db.query(table, where: "age < ?", whereArgs: [age]);
    // var res = await db.rawQuery('SELECT * FROM my_table WHERE age >?', [age]);
    return res;
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data
  Future<int> update(AlarmModel alarmModel) async {
    Map<String, dynamic> row = {
      columnName: alarmModel.name,
      columnDateTime: alarmModel.dateTime.toString(),
      columnIsOn: alarmModel.isOn.toString()
    };
    Database db = await instance.database;
    var res = await db
        .update(table, row, where: "id = ?", whereArgs: [alarmModel.id]);
    return res;
  }

  Future<void> databaseclear() async {
    Database db = await instance.database;

    db.delete(table);
  }
}
