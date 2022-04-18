import 'package:flutter/material.dart';
import 'package:habits_organizer/context/habit_context.dart';
import 'package:habits_organizer/context/todo_context.dart';
import 'package:provider/provider.dart';

class HabitOrganizerContext with ChangeNotifier, TodoContext, HabitContext {
  static HabitOrganizerContext of(BuildContext context, {listen = false}) {
    return Provider.of<HabitOrganizerContext>(context, listen: listen);
  }
}
