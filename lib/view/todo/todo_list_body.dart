import 'package:flutter/material.dart';
import 'package:habits_organizer/context/context.dart';
import 'package:habits_organizer/database/models/models.dart';
import 'package:habits_organizer/view/todo/todo_list_tile.dart';
import 'package:provider/provider.dart';

class TodoListBody extends StatelessWidget {
  const TodoListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitOrganizerContext>(
      builder: (BuildContext context, appContext, Widget? child) {
        return FractionallySizedBox(
          heightFactor: 1,
          widthFactor: 1,
          child: ListView.builder(
            itemCount: appContext.todos.length,
            itemBuilder: (BuildContext context, int idx) {
              Habit habit = appContext.habits.firstWhere(
                  (habit) => habit.id == appContext.todos[idx].habitId);
              return TodoListTile(
                habit: habit,
                todo: appContext.todos[idx],
                idx: idx,
              );
            },
          ),
        );
      },
    );
  }
}
