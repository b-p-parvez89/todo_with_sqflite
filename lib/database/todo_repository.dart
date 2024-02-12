import 'package:sqflite/sqflite.dart';
import 'package:todo_with_sqflite/model/db_model.dart';

import 'db_helper.dart';

class TodoRepository {
  Future<void> insertTodo(Todo todo) async {
    final Database db = await DatabaseHelper.instance.database;
    await db.insert('todo', todo.toMap());
  }

  Future<List<Todo>> getAllTodo() async {
    final Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return Todo(
          id: maps[i]['id'],
          isDone: maps[i]['isDone'],
          title: maps[i]["title"],
          description: maps[i]['description']);
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final Database db = await DatabaseHelper.instance.database;
    await db.update('todo', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }
  Future <void>deleteTodo(int id) async{
    final Database db = await DatabaseHelper.instance.database;
    await db.delete('todo', where: 'id=?', whereArgs: [id]);
  }
}
