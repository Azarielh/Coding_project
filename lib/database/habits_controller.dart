import 'package:habits_organizer/database/database_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:habits_organizer/database/models/habits.dart';

class HabitsController {
  static final HabitsController _habitsController = HabitsController._internal();
  static final DatabaseController _controller = DatabaseController();
  factory HabitsController() {
    return _habitsController;
  }

  HabitsController._internal();

  Future<List<Habits>> getAllHabits() async {
    Database db = await _controller.database;
    List<Map<String, dynamic>> habitsListQuery = [];
    List<Habits> habits = [];
    habitsListQuery = await db.query(_controller.habitsTable);
    for (var habit in habitsListQuery) {
      habits.add(Habits()..fromMap(habit));
    }
    return (habits);
  }

  Future<Habits> insert(Habits habit) async {
    Database db = await _controller.database;
    habit.id = await db.insert(_controller.habitsTable, habit.asMap());
    return habit;
  }

  Future<int> update(Habits habit) async {
    Database db = await _controller.database;
    return await db.update(_controller.habitsTable, habit.asMap(),
        where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<int> delete(Habits habits) async {
    Database db = _controller.database;
    return await db.delete(_controller.habitsTable, where: 'id = ?', whereArgs: [habits.id]);
  }
}