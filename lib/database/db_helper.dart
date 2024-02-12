import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
 static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
static Database? _database;
DatabaseHelper._privateConstructor();

Future <Database> get database async {
  if(_database !=null) return _database!;
  _database=await _initDatabase();

  return _database!;
}
 
 Future <Database> _initDatabase() async{
  String path=join(await getDatabasesPath(),'todo_database.db');
  return await openDatabase(path,
  version: 1,
  onCreate: _createDb,

  
  );
 }

Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isDone INTEGER
      )
      ''');
 }


}