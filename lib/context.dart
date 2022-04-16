import 'package:flutter/material.dart';
import 'package:habits_organizer/database/habits_controller.dart';
import 'package:habits_organizer/database/todo_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'database/models/models.dart';

class HabitOrganizerContext extends ChangeNotifier {
  final HabitsController _habitsController = HabitsController();
  final TodoController _todoController = TodoController();

  List<Habit> habits = [];
  List<Todo> todos = [];

  /// Mo Tu We ...
  late String currentDay;

  /// Iso8601String
  late String currentDate;

  HabitOrganizerContext() {
    currentDay = DateFormat.EEEE().format(DateTime.now());
    currentDate = DateTime.now().toIso8601String();
  }

  Future<List<Todo>> getAllTodoFromHabit(Habit habit) async {
    return await _todoController.getAllTodo(habitId: habit.id);
  }

  getAllHabits() async => habits.addAll(await _habitsController.getAllHabits());

  Future<Habit> editCreateHabit(
      {required Map<String, dynamic> data,
      Habit? habit,
      bool notifie = true}) async {
    if (habit != null) {
      await _habitsController.update(habit..fromMap(data));
      habits.where((habt) => habt.id == habit!.id).first.fromMap(habit.asMap());
      await check1Habit(habit);
      if (notifie == true) {
        notifyListeners();
      }
      return (habit);
    }
    habit = Habit()..fromMap(data);
    habit = await _habitsController.insert(habit);
    habits.add(habit);
    await check1Habit(habit);
    if (notifie == true) {
      notifyListeners();
    }
    return (habit);
  }

  Future<void> removeHabit(Habit habit) async {
    List<Todo> _todos;
    await _habitsController.delete(habit);
    _todos = await _todoController.getAllTodo(habitId: habit.id);
    for (var todo in _todos) {
      await _todoController.delete(todo);
    }
    todos.removeWhere((element) => element.habitId == habit.id);
    habits.removeWhere((element) => element.id == habit.id);
    notifyListeners();
  }

  todoNotifyListeners() => super.notifyListeners();

  Future<void> lockTodo(Todo todo) async {
    await _todoController.insert(todo..done = 1);
  }

  Future<void> check1Habit(Habit habit) async {
    String day = currentDay.substring(0, 2);
    List<Todo> _todos = await getAllTodoFromHabit(habit);

    for (var todo in _todos) {
      if (DateTime.parse(todo.dateTime).day == DateTime.now().day &&
          DateTime.parse(todo.dateTime).month == DateTime.now().month) {
        todos.add(todo);
        return;
      }
    }

    if (habit.frequence == Frequence.daily) {
      if (habit.jours != null && habit.jours!.contains(day)) {
        Todo todo = Todo();
        todo.habitId = habit.id!;
        todo.dateTime = currentDate;
        todos.add(todo);
      }
    }
  }

  static HabitOrganizerContext of(BuildContext context, {listen = false}) {
    return Provider.of<HabitOrganizerContext>(context, listen: listen);
  }
}
