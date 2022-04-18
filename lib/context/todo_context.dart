import 'package:flutter/cupertino.dart';
import 'package:habits_organizer/database/models/models.dart';
import 'package:habits_organizer/database/todo_controller.dart';
import 'package:intl/intl.dart';

mixin TodoContext on ChangeNotifier {
  final TodoController _todoController = TodoController();

  List<Todo> todos = [];

  Future<List<Todo>> getAllTodoFromHabit(Habit habit) async {
    return await _todoController.getAllTodo(habitId: habit.id);
  }

  Future<void> deleteTodo(Todo todo) async {
    await _todoController.delete(todo);
  }

  Future<void> lockTodo(Todo todo) async {
    await _todoController.insert(todo..done = 1);
  }

  bool _checkForTodoDaily(Habit habit, List<Todo> todos, String currentDay) {
    if (habit.frequence != Frequence.daily) return (false);
    for (var todo in todos) {
      if (DateTime.parse(todo.dateTime).day == DateTime.now().day &&
          DateTime.parse(todo.dateTime).month == DateTime.now().month &&
          DateTime.parse(todo.dateTime).year == DateTime.now().year) {
        todos.add(todo);
        return (false);
      }
    }
    if (habit.jours != null && habit.jours!.contains(currentDay)) {
      return (true);
    }
    return (false);
  }

  bool _checkForTodoMensuel(Habit habit, List<Todo> todos, String currentDay) {
    if (habit.frequence != Frequence.mensuel) return (false);

    todos.removeWhere((todo) {
      return DateTime.parse(todo.dateTime).month != DateTime.now().month ||
          DateTime.parse(todo.dateTime).year != DateTime.now().year;
    });

    for (var todo in todos) {
      if (DateTime.parse(todo.dateTime).day == DateTime.now().day) {
        todos.add(todo);
        return (false);
      }
    }

    if (habit.iteration > todos.length) {
      return (true);
    }
    return (false);
  }

  bool _checkForTodoHebdo(Habit habit, List<Todo> todos, String currentDay) {
    if (habit.frequence != Frequence.mensuel) return (false);

    for (var todo in todos) {
      if (DateTime.parse(todo.dateTime).day == DateTime.now().day &&
          DateTime.parse(todo.dateTime).month == DateTime.now().month &&
          DateTime.parse(todo.dateTime).year == DateTime.now().year) {
        todos.add(todo);
        return (false);
      }
    }

   /* if (habit. > todos.length) {
      return (true);
    }
    */
    return (false);
  }



  Future<void> checkForTodo(Habit habit) async {
    String cDay = DateFormat.EEEE().format(DateTime.now()).substring(0, 2);
    String cDate = DateTime.now().toIso8601String();

    todos.removeWhere((todo) => todo.habitId == habit.id);
    List<Todo> _alreadyTodos = await getAllTodoFromHabit(habit);

    if (_checkForTodoDaily(habit, _alreadyTodos, cDay) || _checkForTodoMensuel(habit, _alreadyTodos, cDay)) {
      Todo todo = Todo();
      todo.habitId = habit.id!;
      todo.dateTime = cDate;
      todos.add(todo);
    }
  }
}
