import 'package:flutter/material.dart';
import 'package:habits_organizer/libraries/cloud_background.dart';
import 'package:habits_organizer/libraries/habit_organiser_shimmer.dart';
import 'package:habits_organizer/view/habits/list/habit_list_view.dart';
import 'package:habits_organizer/view/habits/stats/habits_stat.dart';
import 'package:habits_organizer/view/todo/todo_list_body.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  static const String todoRouteName = "/todo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const HabitOrganizerShimmer(child: Text("Daily Task")),
          backgroundColor: Colors.deepPurple,
          actions: [
            HabitOrganizerShimmer(
              child: IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, HabitStat.habitStatRouteName),
                  icon: const Icon(Icons.query_stats)),
            ),
            HabitOrganizerShimmer(
              child: IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, Listhabits.listhabitsRouteName),
                  icon: const Icon(Icons.star_half)),
            )
          ]),
      body:  const CloudBackground(child: TodoListBody()),
    );
  }
}
