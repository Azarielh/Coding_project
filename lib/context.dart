import 'package:flutter/cupertino.dart';
import 'package:habits_organizer/appbars.dart';
import 'package:habits_organizer/database/habits_controller.dart';
import 'package:habits_organizer/view/listhabits.dart';
import 'database/models/models.dart';
import 'package:root/context.dart';
import 'package:provider/provider.dart';
import 'package:root/root.dart';
import 'package:root/home.dart';

class HabitOrganizerContext extends AppContext {
  final HabitsController _habitsController = HabitsController();

  List<Habit> habits = [];

  Future<Habit> addHabits(Map<String, dynamic> map) async {
    Habit habit = Habit()..fromMap(map);
    habit = await _habitsController.insert(habit);
    habits.add(habit);
    Home.ofContext?.body = const Listhabits();
    Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
    return (habit);
  }

  Future<Habit> editHabits(Habit habit, Map<String, dynamic> map) async {
    await _habitsController.update(habit..fromMap(map));
    return (habit);
  }

  getAllHabits() async => habits.addAll(await _habitsController.getAllHabits());

  Future<void> removeHabit(Habit habit) async {
    habits.remove(habit);
    await _habitsController.delete(habit);
  }

  List<Todo> todo = [];

  static HabitOrganizerContext get ofRootContext {
    return Provider.of<HabitOrganizerContext>(Root.context!, listen: false);
  }

  static HabitOrganizerContext of(BuildContext context, {listen = false}) {
    return Provider.of<HabitOrganizerContext>(context, listen: listen);
  }
}
