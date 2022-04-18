import 'package:flutter/foundation.dart';
import 'package:habits_organizer/context/todo_context.dart';
import 'package:habits_organizer/database/habits_controller.dart';
import 'package:habits_organizer/database/models/models.dart';

mixin HabitContext on TodoContext, ChangeNotifier {
  final HabitsController _habitsController = HabitsController();

  List<Habit> habits = [];

  getAllHabits() async => habits.addAll(await _habitsController.getAllHabits());

  Future<Habit> editCreateHabit(
      {required Map<String, dynamic> data,
      Habit? habit,
      bool notifie = true}) async {
    if (habit != null) {
      habit.id = await _habitsController.update(habit..fromMap(data));
      habits.where((habt) => habt.id == habit!.id).first.fromMap(habit.asMap());
      await checkForTodo(habit);
      if (notifie == true) notifyListeners();
      return (habit);
    }
    habit = Habit()..fromMap(data);
    habit = await _habitsController.insert(habit);
    habits.add(habit);
    await checkForTodo(habit);
    if (notifie == true) notifyListeners();
    return (habit);
  }

  Future<void> removeHabit(Habit habit) async {
    List<Todo> _todos;
    await _habitsController.delete(habit);
    _todos = await getAllTodoFromHabit(habit);
    for (var todo in _todos) {
      await deleteTodo(todo);
    }
    todos.removeWhere((element) => element.habitId == habit.id);
    habits.removeWhere((element) => element.id == habit.id);
    notifyListeners();
  }

  Future<void> checkForTotoTodayTodoToday() async {
    if (todos.isNotEmpty) return;
    for (var habit in habits) {
      await checkForTodo(habit);
    }
    notifyListeners();
  }
}
