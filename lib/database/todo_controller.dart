import 'package:habits_organizer/database/database_controller.dart';
import 'package:habits_organizer/database/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoController {
  static final TodoController _todoController = TodoController._internal();
  static final DatabaseController _controller = DatabaseController();

  factory TodoController() {
    return _todoController;
  }

  TodoController._internal();

  Future<List<Todo>> getAllTodo({int? habitId}) async {
    Database db = await _controller.database;
    List<Map<String, dynamic>> todoListQuery = [];

    List<Todo> todos = [];
    if (habitId == null) {
      todoListQuery = await db.query(_controller.todoTable);
    } else {
      todoListQuery = await db.query(_controller.todoTable,
          where: 'habit_id = ?', whereArgs: [habitId]);
    }
    for (var todo in todoListQuery) {
      todos.add(Todo()..fromMap(todo));
    }
    return todos;
  }

  Future<Todo> insert(Todo todo) async {
    Database db = await _controller.database;
    todo.id = await db.insert(_controller.todoTable, todo.asMap());
    return todo;
  }

  Future<int> update(Todo todo) async {
    Database db = await _controller.database;
    return await db.update(_controller.todoTable, todo.asMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(Todo todo) async {
    Database db = await _controller.database;
    return await db
        .delete(_controller.todoTable, where: 'id = ?', whereArgs: [todo.id]);
  }
}
