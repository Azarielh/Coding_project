import 'package:flutter/cupertino.dart';
import 'package:habits_organizer/database/habits_controller.dart';
import 'package:habits_organizer/main.dart';
import 'database/models/models.dart';
import 'package:root/context.dart';
import 'package:provider/provider.dart';
import 'package:root/root.dart';
import 'package:root/home.dart';

class HabitOrganizerContext extends AppContext {
  final HabitsController _habitsController = HabitsController();

  List<Habits> habits = [];

  Future<Habits> addHabits(Map<String, dynamic> map) async {
    Habits habit = Habits()..fromMap(map);
    habit = await _habitsController.insert(habit);
    habits.add(habit);
    Home.ofContext?.body = const Habbits();
    Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
    return (habit);
  }

  getAllHabits() async => habits.addAll(await _habitsController.getAllHabits());

  List<Habits> todo = [];

  static HabitOrganizerContext get ofRootContext {
    return Provider.of<HabitOrganizerContext>(Root.context!, listen: false);
  }

  static HabitOrganizerContext of(BuildContext context, {listen = false}) {
    return Provider.of<HabitOrganizerContext>(context, listen: listen);
  }
}