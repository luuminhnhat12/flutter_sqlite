import 'package:flutter_application_flutter_sqlite/services/todo_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService{
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async{
    const name = 'todo.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async{
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await TodoDB().createTable(db, version);
      }, 
      singleInstance: true
    );
    return database;
  }
  Future<int> update({required int id, String? description}) async{
    final db = await DatabaseService().database;
    return await db.update(
      'todo',
      {
        'description': description
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id]
    );
  }
  Future<int> delete({required int id}) async{
    final db = await DatabaseService().database;
    return await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}