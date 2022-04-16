import 'package:habits_organizer/database/database_controller.dart';
import 'package:habits_organizer/database/models/habits.dart';
import 'package:sqflite/sqflite.dart';

class HabitsController {
  static final HabitsController _habitsController =
      HabitsController._internal();
  static final DatabaseController _controller = DatabaseController();

  factory HabitsController() {
    return _habitsController;
  }

  HabitsController._internal();

  Future<List<Habit>> getAllHabits() async {
    Database db = await _controller.database;
    List<Map<String, dynamic>> habitsListQuery = [];
    List<Habit> habits = [];
    habitsListQuery = await db.query(_controller.habitsTable);
    for (var habit in habitsListQuery) {
      habits.add(Habit()..fromMap(habit));
    }
    return (habits);
  }

  Future<Habit> insert(Habit habit) async {
    Database db = await _controller.database;
    habit.id = await db.insert(_controller.habitsTable, habit.asMap());
    return habit;
  }

  Future<int> update(Habit habit) async {
    Database db = await _controller.database;
    return await db.update(_controller.habitsTable, habit.asMap(),
        where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<int> delete(Habit habits) async {
    Database db = await _controller.database;
    return await db.delete(_controller.habitsTable,
        where: 'id = ?', whereArgs: [habits.id]);
  }
}
