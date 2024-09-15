import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_flutter_sqlite/model/todo.dart';
import 'package:flutter_application_flutter_sqlite/services/database_service.dart';

class TodoDB{
  final tablename = 'todo';
  Future<void> createTable(Database db, int version) async{
    await db.execute('''
      CREATE TABLE  if not exists $tablename (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }
  Future<int> insert({required String title, required String description}) async{
    final db = await DatabaseService().database;
    return await db.rawInsert(''' 
      INSERT INTO $tablename(title, description) VALUES(?, ?)
    ''', [title, description]);
  }
  Future<List<Todo>> fetchAll() async{
    final db = await DatabaseService().database;
    final todo = await db.rawQuery('''
      SELECT * FROM $tablename
    ''');
    return todo.map((e) => Todo.fromSqfliteDatabase(e)).toList();
  }

}